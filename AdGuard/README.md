<h1 align="center">AdGuard Installer</h1>
<h4 align="center">Nhưng Mà Cho Các Router VNPT</h4>

## 1: <ins>Yêu Cầu</ins>
<img src="https://avatars.githubusercontent.com/u/30082422" width="128" height="128" alt="adguard" align="right" />
* Bạn Phải Kích Hoạt Được Telnet/SSH Trên Router VNPT
* Có Hiểu Biết Về Networking Và Biết Ứng Phó Những Lỗi Xảy Ra!
* Phải Có Thông Tin Để Truy Cập Được Trang Gateway Để Chỉnh Router!

> [!CAUTION]
> **⚠️ Miễn trừ trách nhiệm ⚠️**<br>
> Bạn Phải Tự Chịu Trách Nhiệm Hậu Quả Nếu Làm Sai Các Bước Được Hướng Dẫn Trong Này.<br>

## 2: <ins>Quay DNS</ins>
* Trước Hết Bạn Đăng Nhập Vào Trang Gateway. <br>
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/9acfd885-1bfe-42f3-a7c6-c4ca0401e477" />
* Tiếp Đến Hãy Vào Tab ```Network -> LAN``` . <br>
<img width="1293" height="138" alt="image" src="https://github.com/user-attachments/assets/6f84ff0b-a85d-4c7d-874a-f77686e58129" />






Bạn có thể chạy trình cài đặt bằng cách copy lệnh dưới và paste trong phiên SSH/Telnet của VNPT!
```
cd /tmp/userdata/ && /userfs/bin/curl -s -k -o AdGuard.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/main/AdGuard/install-ns.sh && chmod +x AdGuard.sh && sh AdGuard.sh
```
