#!/bin/sh

# Autorun.sh
# Copyright © 2025-2026 Expl01tHunt3r, collaborators and contributors.
#
# Note: this exactly a shell script run in terminal

GREEN='\033[32m'
B_MAGENTA='\033[95m'
RED='\033[31m'
RESET='\033[0m'
YELLOW='\033[33m'
CYAN='\033[36m'
if [ ! -d /etc/safegatea ]; then
    echo -e "${RED}Can't run this patch"
    echo -e "${RED}You must read about this for resolve this issue!"
    echo -e "${GREEN}https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/Integrations/autorun#1-y%C3%AAu-c%E1%BA%A7u"
    exit 1
fi
echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
echo -e "\033[31;43mScript Make By AppleSang With <3\033[0m\n"
echo -e "${RED}############################################################\n"
echo -e "${GREEN} https://github.com/Expl01tHunt3r/vnptmodemresearch\n"
echo -e "${RED}############################################################\n"
echo -e "        ${YELLOW}Press enter to confirm for patch ${CYAN}Autorun${RESET}"
read _

STC='#!/bin/sh
/tmp/userdata/startup.sh >/dev/null 2>&1
echo 1
'
cd /etc/safegate || exit 1

echo "$STC" > init.sh
echo "$STC" > md5.sh
echo "$STC" > safegate.sh
chmod +x init.sh md5.sh safegate.sh

cd /tmp/userdata || exit 1
echo -e "echo This router have been patched with Autorun.\necho ${GREEN}From https://github.com/Expl01tHunt3r/vnptmodemresearch${RESET} with <3.\necho You can edit this file to run anything on startup." > startup.sh
chmod +x startup.sh

echo -e "${GREEN}Patch completed!${RESET}"
echo -e "Startup script located at \"/tmp/userdata/startup.sh\""
echo -e "Edit it using echo and sed, or not remove that file and upload your own."
echo -e "Note: The file ${RED}MUST${RESET} named as \"startup.sh\" at \"/tmp/userdata\" to work."
echo -e "${CYAN}Example: ${RED}echo -e 'echo Router have been patched with Autorun.' > startup.sh ${RESET}"
echo -e "Warn: The script in startup.sh ${RED}MUST NOT${RESET} output anything directly to the shell."
