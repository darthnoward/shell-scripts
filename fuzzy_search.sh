#! /bin/sh 
ALIAS_NAME=sc
curr_dir=$PWD
while getopts "arh" OPTION
do 
    case $OPTION in 
        a) 
            cd ~
            ;;
        h)
            printf "Terminal Fussy finder integrated with fzf, bat and xdg.\n\nOptions:\n\t-a\tsearch all files in home directory.\n\t-r\tsearch all files in root directory.\n\n"
            exit
            ;;
        r)
            cd / 
            ;;
        *)
            printf "No such flag option as \"$1\", please try sc -h.\n"
            exit
            ;;
    esac
done
select=$(fzf --height 50% --reverse --border --preview='[[ $(file --mime {}) =~ binary ]] &&
                 echo {} is a binary file ||
                 (bat --style=numbers --color=always {} ||
                  highlight -O ansi -l {} ||
                  coderay {} ||
                  rougify {} ||
                  cat {}) 2> /dev/null | head -500')
if [ ${#select} -eq 0 ]; then
    exit
fi 
if [ -z "$(echo $select | ack '\.\S+$')" ]; then
    vim $select 
elif [ $(echo $select | rev | cut -d "." -f 1 | rev) == "sh" ]; then vim $select 
else
    xdg-open "$select" &
fi
cd $curr_dir 
