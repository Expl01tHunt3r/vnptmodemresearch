#!/bin/sh

GREEN='\033[32m'   
BLUE='\033[34m'   
RESET='\033[0m'    
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo -e "\033[31;43mScript Make By AppleSang With <3\033[0m"
echo ""
echo ""
echo ""
echo -e "############################################################"
echo ""
echo -e "${GREEN} █████╗ ██████╗  ██████╗ ██╗   ██╗ █████╗ ██████╗ ██████"
echo -e "██╔══██╗██╔══██╗██╔════╝ ██║   ██║██╔══██╗██╔══██╗██╔══██╗    "
echo -e "███████║██║  ██║██║  ███╗██║   ██║███████║██████╔╝██║  ██║    "
echo -e "██╔══██║██║  ██║██║   ██║██║   ██║██╔══██║██╔══██╗██║  ██║   "
echo -e "██║  ██║██████╔╝╚██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝     "
echo -e "╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝      ${RESET}"

echo -e "${BLUE}██╗   ██╗███╗   ██╗██████╗ ████████╗"
echo -e "██║   ██║████╗  ██║██╔══██╗╚══██╔══╝"
echo -e "██║   ██║██╔██╗ ██║██████╔╝   ██║   "
echo -e "╚██╗ ██╔╝██║╚██╗██║██╔═══╝    ██║   "
echo -e " ╚████╔╝ ██║ ╚████║██║        ██║   "
echo -e "  ╚═══╝  ╚═╝  ╚═══╝╚═╝        ╚═╝   ${RESET}"
echo ""
echo -e "############################################################"
echo "        Cảm ơn bạn đã sử dụng script của chúng mình!"
echo ""
echo -e "\033[41;37mBạn Hãy Chắc Chắn Đã Đọc Đầy Đủ Tất Cả Mọi Thứ Ở Trên Trang Github!\033[0m"
echo ""
echo -e "${BLUE} https://github.com/Expl01tHunt3r/vnptmodemresearch/blob/main/AdGuard/README.md ${RESET}"
echo ""
echo "        Ấn Enter Để Bắt Đầu Quá Trình Cài Đặt!"
read dummy
echo -e "Bắt đầu quá trình cài đặt."
mkdir -p /tmp/userdata/AdGuard
cd /tmp/userdata/AdGuard
/userfs/bin/curl -s -k -o AdGuard.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/main/AdGuard/AdGuard.sh
chmod +x AdGuard.sh
/userfs/bin/curl -s -k -o ca-certificates.crt https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/main/AdGuard/ca-certificates.crt
export SSL_CERT_FILE=/tmp/userdata/AdGuard/ca-certificates.crt
echo -e "\033[32m[OK]\033[0m Đã tạo thành công thư mục chứa config!"
cd /tmp/SafeGate
/userfs/bin/curl -s -fSL -o AdGuardHome_linux_armv5.tar.gz https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_armv5.tar.gz
echo -e "\033[32m[OK]\033[0m Đã tải file AdGuard thành công!"
tar -xzf AdGuardHome_linux_armv5.tar.gz
rm AdGuardHome_linux_armv5.tar.gz
cd AdGuardHome
chmod +x AdGuardHome
kill -9 $(pidof dnsmasq)
echo -e "\033[32m[OK]\033[0m Đã cài thành công!"
echo -e "\033[31;43mBạn vào trang http://$(ip addr show br0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1):3000 Để Hoàn Tất Thiết Lập Nhé!\033[0m"
echo -e "\033[32mBạn Có thể Đóng Phiên SSH Này!\033[0m"
rm /tmp/userdata/AdGuard.sh
./AdGuardHome -c  /tmp/userdata/AdGuard/AdGuardHome.yaml -w /tmp/SafeGate


