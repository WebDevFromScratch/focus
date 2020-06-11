require 'tempfile'
require 'fileutils'
require './hosts.rb'

hosts_as_entries = CONFIG['hosts'].map{ |host| ["0.0.0.0 #{host}", "::0 #{host}"] }.flatten
focus_contents = ([START_STRING] + hosts_as_entries + [END_STRING]).join("\n")
temp_file = Tempfile.new('hosts')

begin
  contents = File.read(PATH_TO_HOSTS_FILE)
  regex = /^#{START_STRING}.+#{END_STRING}/m
  new_contents = if contents.match?(regex)
                   contents.sub(regex, focus_contents)
                 else
                   "#{contents}\n#{focus_contents}\n"
                 end

  temp_file.puts(new_contents)
  temp_file.rewind
  FileUtils.cp(temp_file.path, PATH_TO_HOSTS_FILE)
ensure
  temp_file.close
  temp_file.unlink
end
