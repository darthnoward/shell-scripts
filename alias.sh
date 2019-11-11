#! /bin/zsh
if [ -f ~/Scripts/MY/alias ]; then 
    rm ~/Scripts/MY/alias
fi
for var in "$@"
do 
    echo "$var has been added."
    tmp=$(echo $var | rev | cut -c 4- | rev)
    tmp2=$(echo $var | rev | cut -c 1- | rev)
    alias=$(cat $var | ack "ALIAS_NAME=")
    if [ ${#alias} -gt 0 ]; then
        tmp=$(echo $alias |  sed 's/ALIAS_NAME=//')
    fi
    tmp3="alias $tmp=~/Scripts/MY/$tmp2"

    echo $tmp3 >> ~/Scripts/MY/alias
done
echo Done! | figlet
