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

install_autorun() {
    cd /tmp && /userfs/bin/curl -s -k -o autorun.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/master/Integrations/autorun/patch.sh && chmod +x autorun.sh && sh autorun.sh
    cd /tmp/userdata/AdGuard && /userfs/bin/curl -s -k -o startup.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/master/Integrations/AdGuard/startup.sh && chmod +x startup.sh
    echo "sh /tmp/userdata/AdGuard/startup.sh" >> /tmp/userdata/startup.sh
    echo "Done loading AdGuardHome startup script."
}

AUTORUN_INSTALLED=true
echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

if [ ! -f /tmp/userdata/startup.sh ]; then
    AUTORUN_INSTALLED=false
fi

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
if [ "$AUTORUN_INSTALLED" = "false" ]; then
    echo -e "${YELLOW}############################################################\n" 
    echo -e "${RESET}Looks like you didn't install our ${CYAN}Autorun${RESET} module yet."
    echo -e "You will need to login into this shell and start AdGuardHome ${BOLD}every single time${RESET} your router reboots."
    echo -e "You can see our Autorun here: ${RED}https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/Integrations/autorun"
    echo -e "${YELLOW}############################################################\n"
    echo -e "${CYAN}Do you want to install Autorun? (${GREEN}Y${CYAN}/${RED}N${CYAN})${RESET}\n"
    read CONFIRM_AUTORUN_INSTALL
    case $CONFIRM_AUTORUN_INSTALL in
        [Yy]* ) install_autorun ;;
        [Nn]* ) echo "You choosed no. Thanks for your confirmation." ;;
        * ) echo -e "Default is no.";;
    esac
else
    cd /tmp && /userfs/bin/curl -s -k -o startup.sh https://github.com/Expl01tHunt3r/vnptmodemresearch/raw/refs/heads/master/Integrations/AdGuard/startup.sh && cp startup.sh /tmp/userdata/startup.sh
fi
/userfs/bin/tcapi set Dhcpd_Entry primary_dns ${IP}
/userfs/bin/tcapi set Dhcpd_Entry dns_mode 1
/userfs/bin/tcapi commit Dhcpd
echo -e "${GREEN}[OK]${RESET} Route DNS into ${IP}."
echo -e "${GREEN}[OK]${RESET} Finished installing AdGuardHome."
echo -e "\033[31;43mVisit http://${IP}:3000 to finish setup!\033[0m"
echo -e "${RED}!!! CLOSE THE TERMINAL, NOT CTRL+C !!!${RESET}"
rm /tmp/userdata/AdGuard.sh
cd /tmp/AdGuardHome && ./AdGuardHome -c /tmp/userdata/AdGuard/AdGuardHome.yaml -w /tmp/ --no-check-update
