#!/bin/sh

# myshell.sh
# Copyright © 2025-2026 Expl01tHunt3r, collaborators and contributors.
#
# Note: this exactly a shell script run in terminal

# add some color
GREEN='\033[32m'
B_MAGENTA='\033[95m'
RED='\033[31m'
RESET='\033[0m'
YELLOW='\033[33m'
CYAN='\033[36m'
# Check req
if [ ! -f /tmp/userdata/startup.sh ]; then
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
echo -e "        ${YELLOW}Press enter to confirm for patch ${CYAN}myshell${RESET}"
read _
# Create 3 file: config.sh // startup.sh // banner.txt in folder myshell
cd /tmp/userdata
mkdir -p myshell
cd myshell
/userfs/bin/curl -s -k -o config.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/master/Integrations/myshell/config.sh && chmod +x config.sh
/userfs/bin/curl -s -k -o startup.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/master/Integrations/myshell/startup.sh && chmod +x startup.sh
/userfs/bin/curl -s -k -o banner.txt https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/master/Integrations/myshell/banner.txt
echo "sh /tmp/userdata/myshell/startup.sh" >> /tmp/userdata/startup.sh
echo -e "${GREEN}Patch completed!${RESET}"
echo -e "${CYAN}You need open telnet and type ${YELLOW}/tmp/userdata/myshell/startup.sh${RESET}"
echo -e "${CYAN}Or just restart router to apply change!"
