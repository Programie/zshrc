which uptime > /dev/null 2>&1
if [ "$?" = "0" ]; then
	UPTIME_DAYS="`uptime | sed -nr 's/.*\s+up ([0-9]+) day(.*)/\1/p'`" # Get number of days (Empty string if < 1 day)
	UPTIME="`uptime | sed -nr 's/.*\s+up ([0-9]+) day(.*) ([0-9]+):([0-9]+)(.*)/\3:\4/p'`" # Get uptime in 'hh:mm' format (Empty string if time < 1 day)

	if [ -z "$UPTIME" ]; then
		UPTIME_MIN="`uptime | sed -nr 's/.*\s+up ([0-9]+) day(.*) ([0-9]+) min(.*)/\3/p'`" # Get uptime in 'x min' format (Empty string if time < 60 min or < 1 day)
		if [ "$UPTIME_MIN" ]; then
			UPTIME="$UPTIME_MIN min"
		fi
	fi

	if [ -z "$UPTIME" ]; then
		UPTIME="`uptime | sed -nr 's/.*\s+up([ ]+)([0-9]+):([0-9]+)(.*)/\2:\3/p'`" # Get uptime in 'hh:mm' format (Empty string if time < 60 min or >= 1 day)
	fi

	if [ -z "$UPTIME" ]; then
		UPTIME_MIN="`uptime | sed -nr 's/.*\s+up ([0-9]+) min(.*)/\1/p'`" # Get uptime in 'x min' format
		if [ "$UPTIME_MIN" ]; then
			UPTIME="$UPTIME_MIN min"
		fi
	fi

	if [ -n "$UPTIME_DAYS" ]; then
		if [ "$UPTIME_DAYS" = "1" ]; then
			UPTIME="1 day, $UPTIME"
		else
			UPTIME="$UPTIME_DAYS days, $UPTIME"
		fi
	fi

	LOAD="`uptime | sed -nr 's/.*\s+load average: (.*)/\1/p'`"
else
	UPTIME="N/A"
	LOAD="N/A"
fi

which last > /dev/null 2>&1
if [ "$?" = "0" ]; then
	USERS="`last | grep 'still logged in' -c`"
else
	USERS="N/A"
fi

echo "\e[0mUptime: \e[1;32m$UPTIME\e[0m   Load: \e[1;32m$LOAD\e[0m   Users: \e[1;32m$USERS\e[0m   Processes: \e[1;32m`ps ax | wc -l | sed -e 's: ::g'`\e[0m"