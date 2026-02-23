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
