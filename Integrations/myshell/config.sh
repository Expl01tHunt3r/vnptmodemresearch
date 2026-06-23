#!/bin/sh
# this for btop, i'm sure it very useful
export XDG_CONFIG_HOME=/tmp/userdata/program/config
export PATH=/tmp/userdata/program:$PATH
export TERMINFO=/tmp/userdata/program
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# this look like motd
uptime=$(awk '{UP=int($1); D=int(UP/86400); H=int((UP%86400)/3600); M=int((UP%3600)/60); S=UP%60; printf "%d days, %d hours, %d minutes, %d seconds\n", D, H, M, S}' /proc/uptime)
MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print int($2/1024)}')
MEM_USED=$(grep MemAvailable /proc/meminfo | awk -v total="$MEM_TOTAL" '{print total - int($2/1024)}')
CPU=$(cat /tmp/cpu_usage)
LOAD=$(awk '{print $1}' /proc/loadavg)
TEMP=$(/usr/bin/cputemp | awk '{print $3}')
download=$(awk '/pon:/ {sub(/:/, ""); printf "%.2f", $2/1024/1024}' /proc/net/dev)
upload=$(awk '/pon:/ {sub(/:/, ""); printf "%.2f", $10/1024/1024}' /proc/net/dev)
PONT=$(/userfs/bin/tcapi get Info_PonPhy Temperature 2>/dev/null | awk '$1!="" {v=$1; if(v>32767)v-=65536; printf "%.2f", v/256}')
GREEN='\033[32m'
RESET='\033[0m'
YELLOW='\033[33m'
CYAN='\033[36m'
echo -e "${GREEN}Login successfully"
echo -e "\n"
echo -e "${YELLOW}====================================================================${RESET}"
echo -e "${GREEN}$(/userfs/bin/tcapi get DeviceInfo_devParaStatic ModelName | awk '{pad=int((68-length($0))/2); sp="" ; while(pad-->0) sp=sp" "; print sp $0}')${RESET}"
echo -e "${YELLOW}====================================================================${RESET}"
echo -e ""
echo -e "${CYAN}Uptime:${RESET} ${uptime}"
echo -e "${CYAN}CPU:${RESET} ${CPU}% | ${TEMP}°C"
echo -e "${CYAN}xPON: ${RESET}${PONT}°C | ${CYAN}Download: ${RESET}${download} ${CYAN}MB ${RESET}// ${CYAN}Upload: ${RESET}${upload} ${CYAN}MB"
echo -e "${CYAN}Load AVG:${RESET} ${LOAD}"
echo -e "${CYAN}RAM:${RESET} ${MEM_USED}MB/${MEM_TOTAL}MB"
echo -e ""
echo -e "${YELLOW}====================================================================${RESET}"
echo -e "\n"
exec /bin/sh
