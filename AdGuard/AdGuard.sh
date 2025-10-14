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
echo ""
# AdGuard - màu xanh lá
echo -e "${GREEN} █████╗ ██████╗  ██████╗ ██╗   ██╗ █████╗ ██████╗ ██████"
echo -e "██╔══██╗██╔══██╗██╔════╝ ██║   ██║██╔══██╗██╔══██╗██╔══██╗    "
echo -e "███████║██║  ██║██║  ███╗██║   ██║███████║██████╔╝██║  ██║    "
echo -e "██╔══██║██║  ██║██║   ██║██║   ██║██╔══██║██╔══██╗██║  ██║   "
echo -e "██║  ██║██████╔╝╚██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝     "
echo -e "╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝      ${RESET}"
echo ""
echo ""
echo ""
echo "${GREEN}        Cảm ơn bạn đã sử dụng script của chúng mình! ${RESET}"
export SSL_CERT_FILE=/tmp/userdata/AdGuard/ca-certificates.crt
cd /tmp/SafeGate
/userfs/bin/curl -s -fSL -o AdGuardHome_linux_armv5.tar.gz https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_armv5.tar.gz
echo -e "\033[32m[OK]\033[0m Đã tải file AdGuard thành công!"
tar -xzf AdGuardHome_linux_armv5.tar.gz
rm AdGuardHome_linux_armv5.tar.gz
cd AdGuardHome
chmod +x AdGuardHome
kill -9 $(pidof dnsmasq)
echo -e "\033[32m[OK]\033[0m Đã chạy AdGuard thành công!"
echo -e "\033[31;43mBạn Có Thể Đóng Phiên SSH Này Và Tạo Phiên SSH Mới!\033[0m"
./AdGuardHome -c  /tmp/userdata/AdGuard/AdGuardHome.yaml -w /tmp/SafeGate
