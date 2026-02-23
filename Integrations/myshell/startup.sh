#!/bin/sh
killall dropbear
/userfs/bin/dropbear -c /tmp/userdata/myshell/sh.sh -b /tmp/userdata/myshell/banner.txt

