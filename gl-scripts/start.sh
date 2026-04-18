#!/bin/bash

# by default the minecraft server gets 70 percent of the currently free ram
# change this value to whatever you think fits, but leave some for the rest of the system
percentage=70

free_ram() {
    local free_bytes=$(grep MemAvailable /proc/meminfo | awk '{print $2 * 1024}')
    echo $(( free_bytes * $percentage / 100 ))
}

ram=$(free_ram)

#validate if the needed version is installed
valid=false
if [ -d ./"$1" ] && [[ -n "$1" ]]; then
	echo "starting server"
else
        echo "specify an valid version e.g. ./start.sh 26.1.2 or install one with ./install.sh 26.1.2"
        exit 1
fi

if [ ! -f ./$1/eula.txt ]; then
	read -p  'Do you agree to the Minecraft EULA at [https://aka.ms/MinecraftEULA]? : (y/n)' eula_answer
		if [[ "$eula_answer" == "y" ]] || [[ "$eula_answer" == "Y" ]]; then
		touch ./$1/eula.txt
		echo "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).
		#Sat Apr 11 20:02:09 CEST 2026
		eula=true" > ./$1/eula.txt
	else
		echo "You have to agree to the minecraft eula to run this software"
	fi
fi

cd ./$1
java -Xms$ram -Xmx$ram -jar ./server.jar nogui
