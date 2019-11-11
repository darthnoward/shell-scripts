#! /bin/zsh 
ALIAS_NAME=serv
if [ -z $(df | ack "root@45.32.114.223") ] 2>/dev/null; then
    sshfs root@45.32.114.223:/var/www/html /home/noward/Server
    figlet Server Mounted!
else
    figlet Server already mounted!
fi
