#!/bin/sh
# this for btop, i'm sure it very useful
export XDG_CONFIG_HOME=/tmp/userdata/btop/config
export PATH=/tmp/userdata/btop:$PATH
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# this look like motd
UP=$(cut -d'.' -f1 /proc/uptime)
H=$(expr $UP / 3600)
R=$(expr $UP % 3600)
M=$(expr $R / 60)
S=$(expr $UP % 60)
MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print int($2/1024)}')
MEM_FREE=$(grep MemAvailable /proc/meminfo | awk '{print int($2/1024)}')
MEM_USED=$(expr $MEM_TOTAL - $MEM_FREE)
CPU=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print int(usage)}')
LOAD=$(awk '{print $1}' /proc/loadavg)
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

echo "============================================="
echo "Uptime: $(echo "${H}h ${M}m ${S}s")"
echo "CPU: ${CPU}%"
/usr/bin/cputemp
echo "Load AVG: ${LOAD}"
echo "RAM: ${MEM_USED}MB/${MEM_TOTAL}MB"
echo "============================================="
echo "${NETINFO}"
