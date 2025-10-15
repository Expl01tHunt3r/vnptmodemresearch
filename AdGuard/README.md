<h1 align="center">AdGuard Installer</h1>
<h4 align="center">Nhưng Mà Cho Các Router VNPT</h4>

## 1: <ins>Yêu Cầu</ins>
<img src="https://avatars.githubusercontent.com/u/30082422" width="128" height="128" alt="adguard" align="right" />

* Bạn Phải Kích Hoạt Được Telnet/SSH Trên Router VNPT Đã Đề Cập Ở [Đây](https://github.com/Expl01tHunt3r/vnptmodemresearch#3-h%C6%B0%E1%BB%9Bng-d%E1%BA%ABn-m%E1%BB%9F-shell)!
* Có Hiểu Biết Về Networking Và Biết Ứng Phó Những Lỗi Xảy Ra!
* Phải Có Thông Tin Để Truy Cập Được Trang Gateway Để Chỉnh Router!

> [!CAUTION]
> **Bạn Phải Tự Chịu Trách Nhiệm Hậu Quả Nếu Làm Sai Các Bước Được Hướng Dẫn Trong Này**.<br>

> [!WARNING]
> Hiện Tại Chỉ Có Xác Nhận Là Chạy Tốt Trên [GW040-NS](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-ns), Cần Được Mọi Người Thử Nghiệm Tiếp! <br>
> Hiện Tại Có Vài Dòng Model H Sẽ Bị Khởi Động Lại Khi Chạy Script, Chưa Rõ Như Nào, Nếu Bạn Chạy Trên Dòng H Thì Hãy Cẩn Thận Nhé!


## 2: <ins>Quay DNS</ins>
* Trước Hết Bạn Đăng Nhập Vào Trang Gateway. <br>
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/7a6a5ea0-7edc-488f-9211-5007ddc9eff7" />

* Tiếp Đến Hãy Vào Tab ```Network -> LAN``` . <br>
<img width="1293" height="138" alt="image" src="https://github.com/user-attachments/assets/6f84ff0b-a85d-4c7d-874a-f77686e58129" />

* Lăn Chuột Xuống Dưới Bạn Sẽ Thấy ```DNS Mode```
<img width="636" height="32" alt="image" src="https://github.com/user-attachments/assets/ec9c5171-b302-49f4-8ece-e3d705dabcb9" />

* Hãy Chuyển Sang Chế Độ ```Manually ``` Và Đặt ```Primary DNS``` Là IP Gateway Của Bạn, Còn ```Secondary DNS``` Thì Là 8.8.8.8
<img width="611" height="101" alt="image" src="https://github.com/user-attachments/assets/f7b939bd-cbb0-4bb1-9a7e-9d1eb423b734" />

* Và Ấn Nút ```Save``` Để Lưu Các Cài Đặt Trên
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/65ca3512-f326-404f-a05b-689a662a64ab" />

## 3: <ins>Cài Đặt</ins>
* Bạn Bắt Đầu Kết Nối SSH/Telnet Vào Router
<img width="469" height="146" alt="image" src="https://github.com/user-attachments/assets/cde8d9f6-be70-44d9-86bd-41d13cd54da5" />

* Tiếp Đến Bạn Dán Câu Lệnh Dưới Và Ấn Enter
```
cd /tmp/userdata/ && /userfs/bin/curl -s -k -o AdGuard.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/main/AdGuard/install-ns.sh && chmod +x AdGuard.sh && sh AdGuard.sh
```

* Sau Khi Bạn Chạy Thì Hãy **CHẮC CHẮN** Đã Đọc Hết Hướng Dẫn Và Ấn Enter!
<img width="982" height="512" alt="image" src="https://github.com/user-attachments/assets/ca525647-5626-486e-a237-7425d160a51f" />

* Quá Trình Tải Và Cài Đặt Sẽ Hoàn Toàn Tự Động Nên Bạn Chỉ Ngồi Chờ.....!
* Sau Khi Cài Xong Bạn Hãy Để Ý Dòng ```Bạn Vào Trang http://192.168...```. Hãy Vào Đúng Trang Đấy Để Tiếp Tục Thiết Lập!
> Giờ Bạn Đóng Phiên SSH/Telnet Đấy Để AdGuard Chạy Nền Nhé! Muốn Sử Dụng Tiếp Thì Kết Nối Lại Bằng Phiên SSH/Telnet Khác!
<img width="977" height="512" alt="image" src="https://github.com/user-attachments/assets/83374ff7-cb10-41dc-9b3e-e4ada4701c39" />

## 4: <ins>AdGuardHome</ins>
* Sau Khi Bạn Vào Được Web Cài Đặt Của AdGuard Thì Hãy Ấn ```Bắt Đầu```
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/37f99b39-eacc-438a-bda4-18c7ef6a0ff4" />

* Ở Bước Tiếp Theo Bạn Phải Chọn WebPort Khác 80. <br>
 *Ở Đây Mình Sẽ Chọn Port 88*
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/b010a066-c1b9-4af4-956a-e5b99bc7beca" />

* Ở Dòng ```Máy Chủ DNS``` Thì Bạn Hãy Để Nguyên Nhé!
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/8549bac7-2c3b-44de-92f4-303eeef7e784" />

* Tiếp Đến Bạn Sẽ Thiết Lập Tài Khoản Quản Lý AdGuard
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/5c31d559-8cc8-4bdd-bced-3c77ad7d71b7" />

* Bạn Ấn ```Tiếp -> Tiếp -> Mở Bảng Điều Khiển```
* Và Xong! Bạn Đã Thành Công Việc Cài Đặt AdGuard. Còn Lại Về Tinh Chỉnh, Chặn Này, Lọc Nọ Thì Có Đầy Trên Internet, Bạn Có Thể Tìm Hiểu Trên Đó!
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/9a8792c2-c2d3-4db9-8c37-e770308dd6d9" />

## 5: <ins>"Mất Điện"</ins>
> Tại Sao Lại Có Mục Này? Ở [FAQ](https://github.com/Expl01tHunt3r/vnptmodemresearch/blob/main/AdGuard/README.md#6-faqs) Sẽ Lý Giải!
* Bạn Sẽ Tiến Hành SSH/Telnet Vào Cục Router VNPT Lại
<img width="456" height="133" alt="image" src="https://github.com/user-attachments/assets/551a9f3e-c71c-4d89-b95a-c597a9e4d88f" />

* Và Bạn Sẽ Nhập Câu Lệnh Này Vào Và Ấn Enter!
```
/tmp/userdata/AdGuard/AdGuard.sh
```
<img width="434" height="144" alt="image" src="https://github.com/user-attachments/assets/1e0a7eb4-e603-4255-b497-b9146087f712" />

* Script Sẽ Tự Động Tải Và Cài Lại AdGuard Cho Bạn!
<img width="969" height="503" alt="image" src="https://github.com/user-attachments/assets/2cecc5f5-adb1-4203-a51c-14a3d30f1bd5" />

* Và Bạn Đóng Phiên SSH/Telnet Đấy Để Cho AdGuard Luôn Chạy Nền!

## 6: <ins>FAQs</ins>
* **?: Tại Sao Lại Phải Chạy Script Sau Khi Cúp Điện?**
  * Bởi Vì Các File AdGuardHome(Trừ Config) Thì Đều Lưu Ở /tmp/SafeGate, Mà Ở Đấy Lại Lưu Dữ Liệu Ở RAM Nên Sau Khi Reboot Mọi Thứ Sẽ Mất!
* **?: Tại Sao Các Số Liệu Của AdGuardHome Đều Về 0 Khi Khởi Động Lại?**
  * Như Ở Trên, Cả File Database Đều Lưu Tại /tmp/SafeGate Nên Nó Cũng Sẽ Mất Khi Restart!
  > Lỗi chi tiết hơn: Là chỗ lưu /tmp/userdata/AdGuard/data nó không hỗ trợ nmap(2) vì format không hỗ trợ, cần bạn nào tìm hiểu phương pháp lưu các file database!
* **?: Tại Sao Lại Phải Set ```Secondary DNS``` Là Máy Chủ DNS Public Bên Thứ 3?**
  * Nếu Như Bạn Chưa Kịp Cài Lại AdGuardHome, Router Sẽ Quay DNS Từ ```Secondary DNS``` Để Nhà Bạn Vẫn Tiếp Tục Kết Nối Với Mạng!
* **?: Ở Bước [Quay DNS](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/main/AdGuard#2-quay-dns) Và Tại Mục ```Secondary DNS``` Mình Có Thể Set DNS Khác Không?**
  * Được Chứ! Bạn Có Thể Set Các DNS Public Như `1.1.1.1`, `8.8.4.4`, [`94.140.14.14`](https://adguard-dns.io/vi/public-dns.html)...
* **?: Tại Sao Điện Thoại Mình Lại Không Được Chặn Quảng Cáo Từ AdGuardHome?**
  * Bạn Hãy Vào ```Cài Đặt -> Kết Nối -> Cài Đặt Kết Nối Khác``` Và Chỉnh ```DNS Riêng Tư``` Thành ```Tắt```
  > Đấy là cách chỉnh dựa trên điện thoại Samsung, các điện thoại Android khác lẫn IPhone cũng sẽ có cách <br>
  > Cứ tra google là được mà
* **?: Mình Tới Bước `Máy Chủ DNS` Của AdGuardHome Nhưng Nó Báo Lỗi `Port 53 Đang Bị Sử Dụng`?**
  * Bạn Mở Một Shell VNPT Mới Và Nhập Lệnh `kill -9 $(pidof dnsmasq)` Sau Đó Reload Lại Trang Và Tiếp Tục Setup!
* **?: "Mình Gập Vấn Đề Khác Về AdGuardHome!"**
  * Bạn Cứ Mở [Issue](https://github.com/Expl01tHunt3r/vnptmodemresearch/issues) Mới Với Title Tag [AdGuard] Để Được Hỗ Trợ Nhé :3








