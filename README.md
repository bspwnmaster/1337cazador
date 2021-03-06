# 1337cazador
Automate network discovery, service scanning, and vulnerability discovery with a single scalable script. Uses freevulnsearch nse for CVE association and searchspoit to display potential exploits. Tested on Kali Linux. Currently set up to accept user input but can be modified to run on a schedule. Does some unique live nmap xml manipulation to show scan progress.
### Command line tools required:
* nmap, searchsploit, xsltproc, firefox, grep, cut, sed, tail. 
### To download default nse used:
* "git clone https://github.com/OCSAF/freevulnsearch.git"
* "cd freevulnsearch/"
* "cp freevulnsearch.nse /usr/share/nmap/scripts"
* "cd /usr/share/nmap/scripts"
* "nmap --script-updatedb" 
### To download and run 1337cazador: 
* "git clone https://github.com/bspwnmaster/1337cazador.git".
* "cd 1337cazador/"
* "chmod +x 1337cazador.sh" to make script executable 
* "./1337cazador.sh" to run
### Default options:
* Nmap scripts and options can be changed to whatever is desired inside the script. 
* By default the scan contains verbose options and the freevulnsearch nse script to search for CVEs. 
* The options are as follows: nmap -sV --version-all -O --osscan-guess -stats-every 3s --script freevulnsearch "$targetnet" -oX result.xml.
Future plans/Brainstorming located at https://github.com/bspwnmaster/1337cazador/wiki.
