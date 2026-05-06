cd /tmp
/userfs/bin/curl -s -fSL -o capuchino.zip --retry 1000 --retry-delay 5 https://github.com/Expl01tHunt3r/vnptmodemresearch/raw/refs/heads/master/theme/capuchino.zip
/etc/safegate/tools/unzip capuchino.zip 
killall boa
