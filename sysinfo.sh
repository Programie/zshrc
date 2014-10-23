STRING=""

which uptime > /dev/null 2>&1
if [ "$?" = "0" ]; then
	if [ -z "$SYSINFO_DISABLE_UPTIME" ]; then
		STRING="$STRING   Uptime: `uptime | sed -e 's/.*up\(.*\)user.*$/\1/' | rev | cut -d ',' -f 2- | rev | sed -e 's/^ *//' -e 's/ *$//'`"
	fi

	if [ -z "$SYSINFO_DISABLE_LOAD" ]; then
		STRING="$STRING   Load: `uptime | sed -e 's/.*load average[s]*: \(.*\)/\1/'`"
	fi
fi

if [ -z "$SYSINFO_DISABLE_USERS" ]; then
	which last > /dev/null 2>&1
	if [ "$?" = "0" ]; then
		STRING="$STRING   Users: `last | grep 'still logged in' -c`"
	fi
fi

if [ -z "$SYSINFO_DISABLE_PROCESSES" ]; then
	STRING="$STRING   Processes: `ps ax | wc -l | sed -e 's: ::g'`"
fi

echo $STRING | sed -e 's/^ *//' -e 's/ *$//'
