# Make this file executable upon creation --> chmod +x focus.sh (assuming it's in the current directory, needs to be done once)
# Run it with the use of "sudo" --> sudo ./focus.sh (assuming it's in the current directory)
# Optionally: make an alias out of it (TODO for myself right now, put it in a place that makes sense & make such alias)

# only supporting Chrome on Mac properly right now
BROWSER="Google Chrome"

# not sure (yet) if I need to run both (off & on)
# ruby off.rb
ruby on.rb
dscacheutil -flushcache
killall -HUP mDNSResponder
if pgrep -xq -- "${BROWSER}"; then
  killall "${BROWSER}"
fi

while pgrep -xq -- "${BROWSER}"
do
  echo "Waiting for ${BROWSER} to close..."
  sleep 0.5
done

open -a "${BROWSER}"
