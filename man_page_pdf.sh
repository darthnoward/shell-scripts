#! /bin/sh 
ALIAS_NAME=manp
while getopts "ha:" OPTION
do 
    case $OPTION in 
        a)
            tmp=""
            for var in "$@"
            do 
                tmp+=" $var"
            done
            tmp=$(echo $tmp | sed 's/-a\S*//')  
            man -t $tmp | ps2pdf - - | zathura - &
            exit
            ;;
        h)
            printf "Read the man page in pdf.\nzathura-pdf-mupdf or zathura-pdf-poppler needed.\n\nUsage:\tmanpdf [OPTION] [EXECUTABLE]\n\n-a\t\tread a merged version of all the argument input\n\nExamples:\n\tmanpdf vim nano\n\tmanpdf -a man bash ranger\n\n"
            exit
            ;;
        *)
            printf "No such flag option as \"$1\",\nTry 'manpdf -h' for more information.\n"
            exit
            ;;
        esac
done
for var in "$@"
do 
    man -t $var | ps2pdf - - | zathura - & 2>/dev/null
done
