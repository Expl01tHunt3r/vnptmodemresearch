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
    echo -e "${GREEN}https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/Integrations/autorun#1-y%C3%AAu-c%E1%BA%A7u${RESET}"
    echo -e "\n\n"
    exit 1
fi
# show text

# Create 3 file: config.sh // startup.sh // banner.txt in folder myshell

# result
