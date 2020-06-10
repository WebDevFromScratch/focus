# Make this file executable upon creation --> chmod +x focus.sh (assuming it's in the current directory, needs to be done once)
# Run it with the use of "sudo" --> sudo ./focus.sh (assuming it's in the current directory)
# Optionally: make an alias out of it (TODO for myself right now, put it in a place that makes sense & make such alias)

# not sure (yet) if I need to run both (off & on)
ruby off.rb
ruby on.rb
# only supporting Chrome on Mac properly right now
dscacheutil -flushcache
killall -HUP mDNSResponder
killall Google\ Chrome
open -a "Google Chrome"
