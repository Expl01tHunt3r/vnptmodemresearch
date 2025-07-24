# VNPT GW020H Reverse Engineering & Rooting Project

## 📌 Mục tiêu dự án

Dự án nhằm mục đích nghiên cứu và khai thác modem **GW020H** và **các dòng modem liên quan (GW040H, NS, ...)** của VNPT, cụ thể:

- Truy cập **root shell** thông qua mạng nội bộ **và** UART.
- Phân tích firmware gốc và các cơ chế bảo vệ.
- Hỗ trợ **debricking** thiết bị trong quá trình vọc vạch.

> ⚠️ **Miễn trừ trách nhiệm**: Dự án này chỉ phục vụ mục đích **nghiên cứu, học tập** và không khuyến khích sử dụng vào các hoạt động vi phạm pháp luật, quyền riêng tư hay điều khoản sử dụng của nhà mạng. Bạn hoàn toàn chịu trách nhiệm nếu sử dụng sai mục đích.

---

## 📂 Nội dung repo

- `flashdump/mtd0.bin` đến `mtd10.bin`: Dump đầy đủ từ modem chạy **firmware gốc ver 1** – có thể phân tích bằng binwalk và dùng để debrinking trong trươngf hợp cần thiết.
- Một bản **initramfs OpenWrt** tương thích với SoC của modem: dùng để **debrick** hoặc mở shell tạm thời.
- Một **tài liệu nội bộ kỹ thuật** của VNPT (tham khảo).
- Các **script** và **notes** cùng với **phần mềm kèm theo** phục vụ việc root và truy cập hệ thống.

---

## 🔧 Hướng dẫn sơ bộ

1. **Kết nối UART**:
   *với một số dòng modem như trong tài liệu nội bộ của vnpt, có thể làm theo hướng dẫn để mở telnet mà không cần làm theo các bước dưới.
   - Yêu cầu mở nắp thiết bị, dùng bộ chuyển đổi UART-to-USB (nên dùng CH340), dây jumper.
   - Xác định vị trí chân cắm gần khu vực đèn LED, gồm 3 khe: `RX`, `TX`, `GND`.
   - ⚠️ Cắm đúng để tránh hư thiết bị.

2. **Bật nguồn** và chờ thiết bị khởi động đến khi xuất hiện dòng:

Please press Enter to activate this console.

3. **Đăng nhập**:
- Nhấn Enter để thấy prompt `tc login:`
- Có 3 tài khoản có thể đăng nhập:
  - `admin / VnT3ch@dm1n`
  - `operator / VnT3ch0per@tor`
  - `customer / customer` (quyền hạn thấp)
- Đăng nhập thành công sẽ vào shell. Gõ `uname -a` để xác nhận.

4. **(Tùy chọn)** Mở Telnet tạm thời (reboot sẽ mất):
```sh
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
```
Địa chỉ Telnet/SSH mặc định: 192.168.1.1

5.**(Tùy chọn)** Boot vào OpenWrt initramfs: xem mục "BOOT WRT" trong thư mục doc

---

##🛠️ Ghi chú kỹ thuật

-SoC: MediaTek EN751221
-Flash NAND: 128MB SPI NAND (F50L1G41LB hoặc một số dòng chip khác)
-Dump được thực hiện bằng cat /dev/mtdX hoặc nanddump từ BusyBox trong OpenWrt initramfs.
-Tài liệu nội bộ đã có sẵn trên Scribd (xem trong doc).
-Credentials và thông tin đăng nhập có trong doc/credentials.txt.

---

##🛠️ Patch romfile.cfg

Giới thiệu:
-romfile.cfg là file cấu hình backup của modem, tải được từ 192.168.1.1 → Maintenance → Backup/Restore.


-File chứa:
+ LOID & mật khẩu LOID
+ SSID, mật khẩu Wi-Fi
+ Cấu hình mạng, firewall, cron task,...
  
- ⚠️ Không nên chia sẻ public vì chứa nhiều thông tin nhạy cảm.
  
-Giải mã & chỉnh sửa
+ File được mã hóa bởi chương trình cfg_manager trong firmware.
+ Đã reverse thành công IV và key để giải mã và mã hóa lại.
+ Tất cả các modem GW dùng chung key → có thể chuyển romfile.cfg giữa các thiết bị.

 - Sử dụng công cụ
+ Dùng script tools/romfileedit.py để giải mã và chỉnh sửa.
+ Yêu cầu: Python + một số thư viện hỗ trợ (xem trong tool).
+ Sau khi chỉnh sửa, cần mã hóa lại và upload qua web UI để modem chấp nhận.


--- 

##Debricking
- Trong một số trường hợp, thiết bị có thể bị brick do một số chỉnh sửa gây tác động và làm hệ thống không thể khởi động, việc này gây bootloop hay web UI không load được ( có thể thử restart boa nếu vẫn còn truy cập được shell ), trong trường hợp không truy cập được shell, thử tắt nguồn bằng nút vật lý và mở lại để reboot thiết bị, nếu vãn không giải quyết được, hãy dùng phương pháp load initramfs tạm thời:
- Tham khảo [OpenWrt Wiki] TP-Link Archer VR1200v (v2).pdf hoặc truy cập theo link https://openwrt.org/inbox/toh/tp-link/archer_vr1200v?s[]=tp%2A&s[]=link%2A mục debricking
- Sau khi vào được shell root của openwrt, có thể flash lại firmware ( các bản mtdX.bin ) , reboot thiết bị để kiểm tra ( vui lòng giữ file backup romfile.cfg của modem bạn để tải lên restore sau khi debricking )












