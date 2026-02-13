#!/bin/sh

# Startup-AdGuardHome-NS.sh
# Copyright © 2025-2026 Expl01tHunt3r, collaborators and contributors.
#
# Note: Startup script for AdGuardHome

if [ ! -e /tmp/AdGuardHome ]; then
    sleep 180
    export SSL_CERT_FILE=/tmp/userdata/AdGuard/ca.crt
    cd /tmp/ || exit 1
    /userfs/bin/curl -s -fSL -o AdG_armv5l.tar.gz \
    https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_armv5.tar.gz
    tar -xzf AdG_armv5l.tar.gz
    rm AdG_armv5l.tar.gz
    cd AdGuardHome || exit 1
    chmod +x AdGuardHome
    pidof dnsmasq >/dev/null && kill $(pidof dnsmasq)
    ./AdGuardHome -c /tmp/userdata/AdGuard/AdGuardHome.yaml -w /tmp/
fi
