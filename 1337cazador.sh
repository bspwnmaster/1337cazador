#!/bin/bash

present_net () {
ip="$(ip address | grep global | cut -d ' ' -f 6)" #ipv4 addresses
interfaces="$(ip address | grep up | cut -d ' ' -f 2 | sed 's/://g' | grep -v lo)" #network interfaces
count=0 #initialize interface count
echo "Choose network to scan by entering the corresponding number:"
for interface in $interfaces #goes through each online interface 
do
	if [ "$interface" ] #the interface exists
	then
		count="$(expr $count + 1)" #increment interface numbering scheme
	else
		echo "No network interfaces found. Please connect to LAN and try again."
		exit 0
	fi
netrange="$(ip address | grep global | grep "$interface" | cut -d ' ' -f 6)" #ipv4/cidr
options="$(echo "$count"")" "$interface" "$netrange")" #organize network choices
done
}

user_answer () { #gets $options from present_net function
echo $options #display network options
read answer #accept user input
selection="$(echo $options | grep $answer)" #grabs entire chosen line
selectionnum="$(echo $options | cut -d ' ' -f 1 | grep $answer)" #grabs chosen selection number
if [ -z "$selectionnum" ] #if selectionnum is empty
then 
	echo "Invalid selection. Please try again"
	exit 0
fi
targetnet="$(echo $selection | cut -d ' ' -f 3)" #grabs chosen network
}

commence_scan () { #gets $targetnet from user_answer
clear #cleans up terminal
echo "Commencing scan against" $targetnet
nmap -sV --stats-every 3s "$targetnet" -oX result.xml >/dev/null 2>&1 & #sends task to background,xml output
nmappid=$! #gets pid of nmap so tail knows when to stop
tail -F -n 0 --pid=$nmappid result.xml 2>/dev/null | grep --line-buffered Scan | cut -d '"' -f 2,6 --output-delimiter=' ' #outputs live scan type and percent complete
}

process_results () { 
xsltproc result.xml -o result.html #creates html file for results
firefox result.html & #opens html page via firefox
echo "Searching database"
searchsploit --colour -w -v -x --nmap result.xml > result.txt #use nmap xml results to search exploit-db
cat result.txt
}

present_net #produces $options
user_answer #accepts $options, produces $targetnet
commence_scan #accepts $targetnet, produces live scan ouput
process_results #produces results from existing files

exit 0 #exit cleanly
