#!/bin/sh

# Btop.sh
# Copyright © 2025-2026 Expl01tHunt3r, collaborators and contributors.
#
# Note: this exactly a shell script run in terminal


GREEN='\033[32m'
B_MAGENTA='\033[95m'
RED='\033[31m'
RESET='\033[0m'
YELLOW='\033[33m'
CYAN='\033[36m'
# Check req
if [ ! -d /tmp/userdata/myshell ]; then
    echo -e "\n\n"
    echo -e "${YELLOW}!! ${RED}Can't run this patch ${YELLOW}!!"
    echo -e "${RED}You must read about this for resolve this issue!"
    echo -e "${GREEN}https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/Integrations/myshell#1-y%C3%AAu-c%E1%BA%A7u${RESET}"
    echo -e "\n\n"
    exit 1
fi
# show text
echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
echo -e "\033[31;43mScript Make By AppleSang With <3\033[0m\n"
echo -e "${RED}############################################################\n"
echo -e "${GREEN} https://github.com/Expl01tHunt3r/vnptmodemresearch\n"
echo -e "${RED}############################################################\n"
echo -e "        ${YELLOW}Press enter to confirm for install ${CYAN}btop${RESET}"
read _

cd /tmp/userdata
mkdir -p btop
cd btop
mkdir -p config
/userfs/bin/curl -Lk -o btop https://github.com/Expl01tHunt3r/vnptmodemresearch/raw/refs/heads/master/Integrations/btop/btop
chmod 777 btop
echo -e "${GREEN}Btop have been installed."
echo -e "${GREEN}Type ${CYAN}btop${GREEN} to use!"
