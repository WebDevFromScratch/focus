require 'tempfile'
require 'fileutils'
require 'json'

class Hosts
  PATH_TO_HOSTS_FILE = '/etc/hosts'
  START_STRING = '# MANAGED BY FOCUS SCRIPT - START'
  END_STRING = '# MANAGED BY FOCUS SCRIPT - END'
  CONFIG = JSON.load(File.open('./config.json', 'r')).freeze
  REGEX = /^#{START_STRING}.+#{END_STRING}/m

  class << self
    def on
      update_contents('on')
    end

    def off
      update_contents('off')
    end

    private

    def update_contents(state)
      new_contents = send("new_contents_for_#{state}")

      temp_file.puts(new_contents)
      temp_file.rewind
      FileUtils.cp(temp_file.path, PATH_TO_HOSTS_FILE)
    ensure
      temp_file.close
      temp_file.unlink
    end

    def new_contents_for_off
      if contents.match?(REGEX)
        contents.sub(REGEX, '').squeeze("\n")
      else
        contents
      end
    end

    def new_contents_for_on
      if contents.match?(REGEX)
        contents.sub(REGEX, focus_contents)
      else
        "#{contents}\n#{focus_contents}\n"
      end
    end

    def focus_contents
      @focus_contents ||= ([START_STRING] + hosts_as_entries + [END_STRING]).join("\n")
    end

    def hosts_as_entries
      CONFIG['hosts'].map{ |host| ["0.0.0.0 #{host}", "::0 #{host}"] }.flatten
    end

    def temp_file
      @temp_file ||= Tempfile.new('hosts')
    end

    def contents
      @contents ||= File.read(PATH_TO_HOSTS_FILE)
    end
  end
end
