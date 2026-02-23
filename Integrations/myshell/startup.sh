#!/bin/sh
killall dropbear
/userfs/bin/dropbear -c /tmp/userdata/myshell/config.sh -b /tmp/userdata/myshell/banner.txt

