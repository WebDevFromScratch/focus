require './hosts.rb'

# TODO: make this safe, take care of potential crashes & interruptions during updates
contents = File.read(PATH_TO_FILE)
regex = /^#{START_STRING}.+#{END_STRING}/m

if contents.match?(regex)
  new_contents = contents.sub(regex, '').squeeze("\n")
  File.open(PATH_TO_FILE, 'w') { |file| file.puts new_contents }
end
