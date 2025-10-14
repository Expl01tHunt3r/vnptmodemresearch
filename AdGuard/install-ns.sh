#!/bin/sh

GREEN='\033[32m'   # AdGuard
BLUE='\033[34m'    # VNPT
RESET='\033[0m'    # Reset về mặc định
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
# AdGuard - màu xanh lá
echo -e "${GREEN} █████╗ ██████╗  ██████╗ ██╗   ██╗ █████╗ ██████╗ ██████"
echo -e "██╔══██╗██╔══██╗██╔════╝ ██║   ██║██╔══██╗██╔══██╗██╔══██╗    "
echo -e "███████║██║  ██║██║  ███╗██║   ██║███████║██████╔╝██║  ██║    "
echo -e "██╔══██║██║  ██║██║   ██║██║   ██║██╔══██║██╔══██╗██║  ██║   "
echo -e "██║  ██║██████╔╝╚██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝     "
echo -e "╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝      ${RESET}"


# VNPT - màu xanh dương
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
echo "${BLUE} https://github.com/Expl01tHunt3r/vnptmodemresearch/blob/main/AdGuard/README.md ${RESET}"
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
echo -e "\033[32m[OK]\033[0m Đã chạy AdGuard thành công!"
echo -e "\033[31;43mBạn Có Thể Đóng Phiên SSH Này Và Tạo Phiên SSH Mới!\033[0m"
rm /tmp/userdata/AdGuard.sh
./AdGuardHome -c  /tmp/userdata/AdGuard/AdGuardHome.yaml -w /tmp/SafeGate


