#! /usr/bin/env sh 
# A shell script written by Darth Noward (https://darthnoward.com)
# Put in package name to check if it's installed in the system.
ALIAS_NAME=pack
while getopts "h" OPTION
do 
    case $OPTION in 
        h)
            printf "This is a shell script utility written by Darth Noward.\nPut in package names as arguments to check if it's installed in the system.\n\n Usage: pack [PACKAGE NAME]\n\nExamples:\n\tpack vim nano\t\tcheck if vim and nano is installed and where is binary for vim and nano\n"
            exit 
            ;;
        *)
            printf "No such flag option as \"$1\", please try pack -h.\n"
            exit 
            ;;
    esac 
done
for var in "$@"
do 
    if command -v $var > /dev/null; then
    printf "\n$var is already installed [`which $var`].\n"
    else
    printf "\n$var is not installed.\n"
    fi 
done 
