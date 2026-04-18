#!/bin/bash

valid=false
version=""

while IFS= read -r line; do #check if the version is supported
  if [[ "${line%% *}" == "$1" ]]; then
    valid=true
    version=$1
  fi
done < ./.versions.txt

if [ $valid == false ]; then
	echo "specify an valid version. e.g. ./install.sh 26.1.2"
	exit 1
fi

if [ ! -d "$version" ]; then #only make an new directory if it doesn't already exist
	mkdir ./"$version"
fi

link=$(cat ./.versions.txt | grep "$version")
link="${link#* }" #cut the version number off the link

echo $link
curl "$link" --output ./"$version"/server.jar

read -p  'Do you agree to the Minecraft EULA at [https://aka.ms/MinecraftEULA]? : (y/n)' eula_answer
if [[ "$eula_answer" == "y" ]] || [[ "$eula_answer" == "Y" ]]; then
	touch ./$version/eula.txt
	echo "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).
#Sat Apr 11 20:02:09 CEST 2026
eula=true" > ./$version/eula.txt
else
	echo "the server is downloaded, but you cannot run it until you agree to the minecraft eula. use the ./start.sh script to get prompted again"
fi

echo "run the start.sh script with ./start.sh to start your server."
