#! /bin/bash
ALIAS_NAME=com
ps aux | sort -nrk 3,3 | head -n 10 | awk 'BEGIN{print "Process" " " "CPU" " " "RAM" " " "PID"}; {print $11 " " $3 " " $4 " " $2}' | rev | cut -f 1 -d "/" | rev | column -t
echo ""
used=$(free -h | grep Mem | awk '{print $3}')
total=$(free -h | grep Mem | awk '{print $2}')
if (echo $used | grep M > /dev/null); then
    percentage=$(echo "$(echo $(echo "scale=2; $(echo "scale=4; $(echo $used | rev | cut -c 3- | rev) / 1024" | bc) / $(free -h | grep Mem | awk '{print$2}' | rev | cut -c 3- | rev)" | bc) | cut -c 2-)")
    if [ ${percentage:0:1} -eq 0 ]; then
        percentage=${percentage:1:2}
    fi
    percentage=$(echo "$percentage%")
else 
percentage=$(echo "$(echo "scale=2; $(free -h | grep Mem | awk '{print $3}' | rev | cut -c 3- | rev) / $(free -h | grep Mem | awk '{print $2}' | rev | cut -c 3- | rev)" | bc | cut -c 2-)%")
fi 
used=$(echo $used | rev | cut -c 2- | rev)
total=$(echo $total | rev | cut -c 2- | rev)
echo "RAM: $used/$total ($percentage)"
echo ""
echo $(df -h | grep sda2 | awk '{print "Disk: " $3 "/" $2}')
echo $(df -h | grep sda5 | awk '{print "Downloads: " $3 "/" $2}')
echo $(df -h | grep sdb1 | awk '{print "SD: " $3 "/" $2}')
