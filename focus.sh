# !/bin/bash

# Make this file executable upon creation --> chmod u+x focus.sh (assuming it's in the current directory, needs to be done once)
# Run it with the use of "sudo" --> sudo ./focus.sh (assuming it's in the current directory)
# Optionally: make an alias out of it (TODO for myself right now, put it in a place that makes sense & make such alias)

# TODO: only supporting Chrome on Mac properly right now - try a similar approach with Firefox
# and make this configurable via config.json
BROWSER="Google Chrome"

echo "-----------------"
echo "Setting browser for focused work..."

ruby on.rb

# Flush system DNS cache
dscacheutil -flushcache
killall -HUP mDNSResponder

# Restart browser in order to clear browser cache
# NOTE: if you don't want to lose open tabs, make sure to set your browser correctly for that. E.g. in Chrome, open
# "chrome://settings/", scroll down to "On start-up" and select "Continue where you left off"
if pgrep -xq -- "${BROWSER}"; then
  pkill -o "${BROWSER}"
fi
while pgrep -xq -- "${BROWSER}"
do
  sleep 0.5
done
open -a "${BROWSER}"
echo "Done!"
echo "-----------------"
