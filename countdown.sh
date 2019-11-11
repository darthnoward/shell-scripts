#! /bin/sh
ALIAS_NAME=ctd
if echo $1 > /dev/null ; then
    a=$1
fi 
if echo $2 > /dev/null ; then 
    b=$2 
fi 
loop() {
newcounter=5
if command -v figlet > /dev/null; then
    if command -v lolcat > /dev/null; then
        if [ -z $2 ]; then
            newcounter=5
        else
            if [ $2 -gt 0 ]; then
                newcounter=$2
            else
                printf "[Error]: option '-l' requires an argument, please put in a positive interger\nAbort\n"
                newcounter=-1
            fi
        fi
    else
       printf "[Error]: dependency 'lolcat' not installed.\nAbort.\n"
       newcounter=0
    fi
else
    printf "[Error]: dependency 'figlet' not installed.\nAbort.\n"
    newcounter=0
fi
counter=$newcounter
while [ $counter -ge 0 ]
do 
    clear
    echo -e "Countdown :  $counter s" | figlet -f banner | lolcat
    if [ $counter -eq 0 ]; then
        echo -e "TIME's UP!" | figlet  
        counter=$(expr $newcounter+1)
    fi
    sleep 1; ((counter--))
done
}
while getopts "hl" OPTION
do
    case $OPTION in
        h)
            printf "This is a countdown utility written by Darth Noward.\nDependencies needed: lolcat, figlet.\n\nUsage:\tctd [OPTION] [TIME]\n\nWith no TIME, by default a timer of 5 seconds will be set and will ask if a reset is needed after the timer is done.\n\n\t-l\t\t\tloop, reset each time without asking\n\nExamples:\n\tctd 20\t\tCountdown 20 seconds, ask for reset.\n\tctd -l 10\tCountdown 10 seconds, don't ask for reset.\n\tctd -l \t\tCountdown 5 seconds, don't ask for reset\n\n"
            exit
            ;;
        l)
            loop $a $b
            exit
            ;;
        *)
            printf "No such flag option as \"$1\".\nTry 'ctd -h' for more information.\n"
            exit
            ;;
    esac
done

clear
newcounter=5
if command -v figlet > /dev/null; then
    if command -v lolcat > /dev/null; then
        if [ $# -eq 0 ]; then
            counter=5
        else 
            if [ $a -gt 0  ]; then
                newcounter=$a
            else 
                printf "[Error]: Please put a positive interger as argument\nAbort.\n"
                newcounter=0
            fi 
        fi
    else 
       printf "[Error]: dependency 'lolcat' not installed.\nAbort.\n"
       newcounter=0 
    fi 
else
    printf "[Error]: dependency 'figlet' not installed.\nAbort.\n"
    newcounter=0 
fi
counter=$newcounter
if [ $counter -gt 0 ]; then
    echo -e "Countdown :  $counter s" | figlet -f banner | lolcat
fi
while [ $counter -gt 0 ]
do 
    sleep 1; ((counter--))
    clear
    echo -e "Countdown :  $counter s" | figlet -f banner | lolcat
    if [ $counter -eq 0 ]; then
        echo -e "TIME'S UP\nRESET? (Y/n)" | figlet  
        read -p ": " reset 
        clear
        counter=$newcounter
        echo -e "Countdown :  $counter s" | figlet -f banner | lolcat
        if [ $reset == "n" ] 2>/dev/null > /dev/null ; then
            counter=0
            clear
            echo -e "DONE" | figlet  
        fi 
    fi
done
