#!/bin/sh

# AdGuardHome-NS.sh
# Copyright © 2025-2026 Expl01tHunt3r, collaborators and contributors.
#
# Note: this exactly a shell script run in terminal

GREEN='\033[32m'   
BLUE='\033[34m'   
RESET='\033[0m'
RED='\033[31m'
YELLOW='\033[33m'
CYAN='\033[36m'
BOLD='\033[1m'


echo -e "\033[31;43mScript Make By AppleSang With <3\033[0m\n"
echo -e "${RED}############################################################\n"
echo -e "${GREEN} https://github.com/Expl01tHunt3r/vnptmodemresearch\n"
echo -e "${RED}############################################################\n"
echo -e "        ${YELLOW}Press enter to confirm installing ${CYAN}AdGuardHome${RESET}"
read _

echo -e "Starting installation..."
mkdir -p /tmp/userdata/AdGuard
cd /tmp/userdata/AdGuard
/userfs/bin/curl -s -k -o ca.crt https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/master/Integrations/AdGuard/accvraiz1.crt
export SSL_CERT_FILE=/tmp/userdata/AdGuard/ca.crt
echo -e "${GREEN}[OK]${RESET} Downloaded certificate."
cd /tmp/
/userfs/bin/curl -s -fSL -o AdG_armv5l.tar.gz https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_armv5.tar.gz
tar -xzf AdG_armv5l.tar.gz
echo -e "${GREEN}[OK]${RESET} Downloaded AdGuardHome."
rm AdG_armv5l.tar.gz
cd AdGuardHome
chmod +x AdGuardHome
kill -9 $(pidof dnsmasq)
IP=$(ip addr show br0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
/userfs/bin/tcapi set Autoexec_Entry adguard "sh /tmp/userdata/AdGuard/startup.sh"
/userfs/bin/tcapi commit Autoexec_Entry
echo -e "${GREEN}[OK]${RESET} Set auto startup for AdGuardHome."
/userfs/bin/tcapi set Dhcpd_Entry primary_dns ${IP}
/userfs/bin/tcapi set Dhcpd_Entry secondary_dns 8.8.8.8
/userfs/bin/tcapi set Dhcpd_Entry dns_mode 1
/userfs/bin/tcapi commit Dhcpd
/userfs/bin/tcapi save
echo -e "${GREEN}[OK]${RESET} Route DNS into ${IP}."
echo -e "${GREEN}[OK]${RESET} Finished installing AdGuardHome."
echo -e "\033[31;43mVisit http://${IP}:3000 to finish setup!\033[0m"
echo -e "${RED}!!! CLOSE THE TERMINAL, NOT CTRL+C !!!${RESET}"
rm /tmp/userdata/AdGuard.sh
cd /tmp/AdGuardHome && ./AdGuardHome -c /tmp/userdata/AdGuard/AdGuardHome.yaml -w /tmp/ --no-check-update
