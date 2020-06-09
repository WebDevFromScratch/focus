require './hosts.rb'

hosts_as_entries = CONFIG['hosts'].map{ |host| ["0.0.0.0 #{host}", "::0 #{host}"] }.flatten
focus_contents = ([START_STRING] + hosts_as_entries + [END_STRING]).join("\n")

# TODO: make this safe, take care of potential crashes & interruptions during updates
contents = File.read(PATH_TO_FILE)
regex = /^#{START_STRING}.+#{END_STRING}/m

if contents.match?(regex)
  new_contents = contents.sub(regex, focus_contents)
else
  new_contents = "#{contents}\n#{focus_contents}\n"
end
File.open(PATH_TO_FILE, 'w') { |file| file.puts new_contents }
