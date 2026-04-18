# Scripts

this document is all about the scripts that come with green lava preinstalled.


## install.sh

The install.sh script is the primary script used to install the Minecraft server
It takes one argument which should be the minecraft version number.

The downloadlinks for the server jars can be found in the .versions.txt file.
The site [mcversions.net](mcversions.net) can be used to get all links to the server download links.

## exit codes

* [1] no valid version is specified
    pass an valid version that is in versions.txt

* [2] user didn't agree to the minecraft Eula
    you need to agree to the minecraft EULA to run an minecraft server

## start.sh

The start.sh script starts the minecraft server that is specified as the first and only argument.

It automaticly assigns ram to the java process at the first script lauch. It calculates 70 percent of the currently free ram, and assigns that amount to the java process.
