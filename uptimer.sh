#!/bin/bash

ut=$(uptime --pretty) #shorter
dd=$(echo "$ut" | grep --only-matching "[0-9]* day" | cut -d " " -f 1)
hh=$(echo "$ut" | grep --only-matching "[0-9]* hour" | cut -d " " -f 1)
mm=$(echo "$ut" | grep --only-matching "[0-9]* minute" | cut -d " " -f 1)

#handle particular cases in the string above. e.g. "3 days, 10 minutes" => no hours.
[[ -n $dd ]] || dd="0"
[[ -n $hh ]] || hh="0"
[[ -n $mm ]] || mm="0"

#compute stuff
current_uptime=$(echo "$dd*24*60+$hh*60+$mm" | bc)
best_uptime=$(head -1 $1 2>/dev/null) #first line of existing file
echo "$best_uptime" | grep "[0-9]\+" > /dev/null || best_uptime="0" #ensure there is actually some number in the first line of the file...

#and the winner is...
if [ $current_uptime -gt $best_uptime ]
then
	echo "$current_uptime"$'\n'"$ut" > "$1" #overwrite with new best uptime (minutes, then pretty-print)
fi
