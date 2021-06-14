#!/bin/bash
kill $(lsof -ti :$1)
IFS=$'\n'

common_ports_and_process='3000|8080|8090|8888|9200|com.docke'

process_list () { 
	lsof -PiTCP -sTCP:LISTEN | egrep -i $common_ports_and_process; 
}

echo "$(process_list | awk '{gsub(/(\*|localhost):/, "");print $9}' | tr '\n' ' ') | color=#CDAC3B | length=30"

echo "---"

for process in $(process_list); do
	process_info=$(echo "$process" | awk '{gsub(/(\*|localhost):/, "");print $1 " " $9}')
	port=$(echo "$process_info" | awk '{print $2}')
	echo $process_info
    echo "-- Kill process on port $port | terminal=false refresh=true bash='$0' param1=$port"
done