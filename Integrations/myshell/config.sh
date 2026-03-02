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
TEMP=$(/usr/bin/cputemp | awk '{print $3}')
raw=$(/userfs/bin/tcapi get Info_PonPhy Temperature 2>/dev/null)
[ -z "$raw" ] && exit 1
PONT=$(awk -v r="$raw" '
BEGIN {
    if (r > 32767)
        r = r - 65536
    printf "%.2f", r/256
}')

GREEN='\033[32m'
RESET='\033[0m'
YELLOW='\033[33m'
CYAN='\033[36m'
echo -e "${GREEN}Login successfully"
echo -e "\n"
echo -e "${YELLOW}=============================================${RESET}"
echo -e "${GREEN}           $(/userfs/bin/tcapi get DeviceInfo_devParaStatic ModelName)"
echo -e "${YELLOW}=============================================${RESET}"
echo -e ""
echo -e "${CYAN}Uptime:${RESET} $(echo "${H}h ${M}m ${S}s")"
echo -e "${CYAN}CPU:${RESET} ${CPU}% | ${TEMP}°C"
echo -e "${CYAN}xPON: ${RESET}${PONT}°C"
echo -e "${CYAN}Load AVG:${RESET} ${LOAD}"
echo -e "${CYAN}RAM:${RESET} ${MEM_USED}MB/${MEM_TOTAL}MB"
echo -e ""
echo -e "${YELLOW}=============================================${RESET}"
echo -e "\n"
exec /bin/sh
