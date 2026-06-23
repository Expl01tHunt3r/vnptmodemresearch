#!/bin/sh

# Startup-AdGuardHome-NS.sh
# Copyright © 2025-2026 Expl01tHunt3r, collaborators and contributors.
#
# Note: Startup script for AdGuardHome
# Note: !!This script only run when in folder tmp doesn't have AdGuardHome!!

if [ ! -e /tmp/AdGuardHome ]; then
    export SSL_CERT_FILE=/tmp/userdata/AdGuard/ca.crt
    cd /tmp/ || exit 1

    while true; do
        /userfs/bin/curl -s -fSL -o AdG_armv5l.tar.gz https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_armv5.tar.gz
        tar -xzf AdG_armv5l.tar.gz
        rm -f AdG_armv5l.tar.gz

        if [ -e /tmp/AdGuardHome ]; then
            break
        else
            sleep 3
        fi
    done
fi

cd /tmp/AdGuardHome || exit 1
chmod +x AdGuardHome
rm AdGuardHome.sig && rm CHANGELOG.md && rm LICENSE.txt && rm README.md
killall dnsmasq
./AdGuardHome -c /tmp/userdata/AdGuard/AdGuardHome.yaml -w /tmp/ --no-check-update
