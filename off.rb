require 'tempfile'
require 'fileutils'
require './hosts.rb'

temp_file = Tempfile.new('hosts')

begin
  contents = File.read(PATH_TO_HOSTS_FILE)
  regex = /^#{START_STRING}.+#{END_STRING}/m

  if contents.match?(regex)
    new_contents = contents.sub(regex, '').squeeze("\n")
    temp_file.puts(new_contents)
    temp_file.rewind
    FileUtils.cp(temp_file.path, PATH_TO_HOSTS_FILE)
  end
ensure
  temp_file.close
  temp_file.unlink
end
