#!/bin/sh
menu()
{
	echo $(date)
	echo '-------------------------------'
	echo 'Main Menu'
	echo '-------------------------------'
	echo '1. Operating system info'
	echo '2. Hostname and DNS info'
	echo '3. Network and info'
	echo '4. Who is online'
	echo '5. Last logged in users'
	echo '6. My IP Address'
	echo '7. My Disk Usage'
	echo '8. My home file-tree'
	echo '9. Process Operations (not implemented)'
	echo '10. Exit'
	read -p 'Enter your choice [1-10] ' input
	echo
}

osinfo()
{
	echo '-------------------------------'
	echo 'System Information'
	echo '-------------------------------'
	echo 'Operating System: '$(uname)
	printf "$(/usr/bin/lsb_release -a)\n"
	read -p 'Press [Enter] to continue...' enter
	echo
}

host_DNS()
{
	echo '-------------------------------'
	echo 'Hostname and DNS information'
	echo '-------------------------------'
	echo 'Hostname: '$(hostname)
	echo 'DNS Domain: '$(domainname)
	echo 'IP Address: '$(hostname -i)
	echo 'DNS name servers (DNS IP): ' ${dnsips}
	echo
}

net_info()
{
	echo '-------------------------------'
	echo 'Network Information'
	echo '-------------------------------'
	echo '*** IP Address Information ***'
	echo 'Total network interfaces found: ' $(ls -A /sys/class/net | wc -l)
	printf "$(ip addr show)\n"
	echo '***********************'
	echo '*** Network Routing ***'
	echo '***********************'
	printf "$(route)\n"
	echo '**************************************'
	echo '*** Interface Traffic Information ***'
	echo '**************************************'
	printf "$(netstat -i)\n"
	read -p 'Press [Enter] to continue...' enter
	echo
}

online()
{
	echo '-----------------------------------------------'
	echo 'Who is online'
	echo '-----------------------------------------------'
	echo 'NAME       LINE         TIME             COMMENT'
	printf "$(who)\n"
	read -p 'Press [Enter] to continue...' enter
	echo
}

last_log()
{
	echo '-----------------------------------------------'
	echo 'List of Last Logged in Users'
	echo '-----------------------------------------------'
	printf "$(last | awk 'NR%2!=0 {print $1 " " $2 "      " $4 " " $5 " " $6 " " $7}')\n"
	read -p 'Press [Enter] to continue...' enter
	echo
}

ipinfo()
{
	echo '-----------------------------------------------'
	echo 'Public IP Information'
	echo '-----------------------------------------------'
	printf "$(curl -s ifconfig.me)\n"
	read -p 'Press [Enter] to continue...' enter
	echo
}

disk()
{
	echo '-----------------------------------------------'
	echo 'Disk Usage Info'
	echo '-----------------------------------------------'
	echo "$(df | awk 'NR>1 {print $5 " " $6 }')\n"
	read -p 'Press [Enter] to continue...' enter
	echo
}

filetree()
{
	echo '-----------------------------------------------'
	echo 'My Home file-tree'
	echo '-----------------------------------------------'
	sh ./proj1.sh 2>/dev/null
	echo
	echo 'Filetree.html created!'
	read -p 'Press [Enter] to continue...' enter
	echo
}
while [ 1 ]
do
	menu
	if [ $input = 1 ]
	then
		osinfo
	elif [ $input = 2 ]
	then
		host_DNS
	elif [ $input = 3 ]
	then
		net_info
	elif [ $input = 4 ]
	then
		online
	elif [ $input = 5 ]
	then
		last_log
	elif [ $input = 6 ]
	then
		ipinfo
	elif [ $input = 7 ]
	then
		disk
	elif [ $input = 8 ]
	then
		filetree
	elif [ $input = 9 ]
	then
		echo 'Process Operations not accounted for!'
		echo
	elif [ $input = 10 ]
	then
		break
	else
		echo "invalid command"
		echo
		
	fi

done


