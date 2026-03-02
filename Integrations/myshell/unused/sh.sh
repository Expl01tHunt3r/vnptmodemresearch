#!/bin/sh
/tmp/userdata/myshell/config.sh
exec /bin/sh



NETINFO=""
for IF in $(grep ":" /proc/net/dev | awk -F: '{print $1}' | sed 's/ //g' | grep -v "^lo$"); do
    LINE=$(grep "$IF" /proc/net/dev | awk -F: '{print $2}')
    RX=$(echo $LINE | awk '{print int($1/1024/1024)}')
    TX=$(echo $LINE | awk '{print int($9/1024/1024)}')

    if [ "$RX" -ne 0 ] || [ "$TX" -ne 0 ]; then
        NETINFO="$NETINFO
$IF: Download ${RX}MB | Upload ${TX}MB"
    fi
done

echo "${NETINFO}"
echo -e ""
echo -e "${YELLOW}=============================================${RESET}"


echo -e ""
echo -e "${YELLOW}=============================================${RESET}"
echo -e ""
echo -e "${CYAN}List device connecting to your network:${RESET}"
/userfs/bin/tcapi show DhcpLease 2>/dev/null | awk '
/\[IP = / {
    ip=$3
    gsub(/\]/,"",ip)
}
/\[HostName = / {
    name=$3
    gsub(/\]/,"",name)

    split(ip, o, ".")
    key = o[1]*16777216 + o[2]*65536 + o[3]*256 + o[4]

    count++
    iplist[count] = ip
    namelist[count] = name
    keylist[count] = key
}

END {
    for (i=1; i<=count; i++) {
        for (j=i+1; j<=count; j++) {
            if (keylist[i] > keylist[j]) {
                tmp=keylist[i]; keylist[i]=keylist[j]; keylist[j]=tmp
                tmp=iplist[i]; iplist[i]=iplist[j]; iplist[j]=tmp
                tmp=namelist[i]; namelist[i]=namelist[j]; namelist[j]=tmp
            }
        }
    }

    for (i=1; i<=count; i++) {
        printf "%-20s %s\n", namelist[i], iplist[i]
    }
}
'
