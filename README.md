<h1 align="center">VNPT Reverse Engineering & Rooting Project</h1>

***<h4 align="center">Không gì là không thể :)</h4>***

## 1: <ins>Mục tiêu</ins>
* Nghiên cứu về các modem nhà 4 chữ (VNPT) (hiện tại đang nghiên cứu các dòng -H, -NS, có thể dòng -HS trong tương lai ~~gần~~)
* Phá firmware, tìm hiểu cơ chế encryption trong firmware (nếu ra và rảnh thì cố mod OpenWRT qua luôn)
* Vọc vạch hỏng modem thì có file để debrick
  
> [!CAUTION]
> **⚠️ Miễn trừ trách nhiệm ⚠️**<br>
> Tất cả nội dung chỉ nhằm mục đích nghiên cứu, học tập.<br>
> Không khuyến khích sử dụng vào các hoạt động vi phạm pháp luật hay xâm phạm hệ thống mạng.<br>
> Người sử dụng hoàn toàn tự chịu trách nhiệm.

#### *(mấy anh dev bên vnpt có thấy repo này đừng fix giùm em 😭)*
---
## 2: <ins>Content</ins>
* [`flashdump/*`](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/main/flashdump) NAND dump của firmware model GW-020H
* [`openwrt-initramfs-en751221/*`](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/main/openwrt-initramfs-en751221) dùng để debrick nếu vọc vạch cháy firmware
* [`tools/*`](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/main/tools) các tool để decrypt và encrypt romfile.cfg
* Dump firmware đã được strip trong [`squashfs-modified`](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/main/squashfs-modified):
	* `boa-dump.bin`: firmware gốc (GW020-H) trong quá trình upgrade qua web UI.
	* `squashfs.image`: phần squashfs đã được tách (GW020-H), có thể giải nén bằng `unsquashfs`.
	* Firmware đã dump đc từ boa của GW040-H
	* squashfs-root(đã giải mã) tại [đây](https://github.com/Expl01tHunt3r/vnptmodemresearch/releases)
---
## 3: <ins>Hướng dẫn mở shell</ins>

> [!WARNING]  
> **⚠️ CẢNH BÁO ⚠️**  
> Việc mở shell có thể vô tình tạo ra lỗ hổng ngay trên hệ thống mạng của bạn!  
> Hãy chắc chắn rằng chỉ có **BẠN** được phép truy cập vào.  
> Bằng việc bạn đặt mật khẩu đăng nhập vào WiFi khó đoán!

### 3.1: UART
* Chuẩn bị USB-UART (khuyến nghị chip CH340) và dây jumper.
* Trên bo mạch gần đèn LED sẽ có 3 chân: `RX`, `TX`, `GND`.
* Kết nối đúng để tránh hỏng phần cứng.
* Lưu ý đảm bảo kết nối tốt dây (có thể hàn cho lành)
### 3.2: Tài khoản login
* Khi boot lên và truy cập bằng uart sẽ thấy :
  ```txt
  Please press Enter to activate this console.
  ```
  * Lưu ý: bản ssh được xài cực cổ lỗ sĩ nên phải bật option insecure (?) mới kết nối được (với dòng GW020H), và muốn dùng telnet/ssh thì phải sửa file romfile.cfg bằng tool và upload lại để mở firewall (iptables với dòng H) hoặc có thể mở theo hướng dẫn với model -NS
* Nếu đã mở telnet và connect vào thì sẽ có: `tc login:`
* Các tài khoản:
  * admin / VnT3ch@dm1n (như root do full quyền)
  * operator / VnT3ch0per@tor (only UART)
  * customer / customer (quyền thấp)
  * user3/ ???? (quyền thấp, chỉ đăng nhập quản trị web, chỉ có trên model NS, chưa xác định đầy đủ)
* Khi đăng nhập thành công sẽ vào trực tiếp shell mặc định (BusyBox Shell)
### 3.3: Telnet/SSH tạm thời (nếu đang sài UART)
* Gõ 3 lệnh sau vào terminal
```bash
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
```
* Xong connect bằng IP gateway (.1.1 hoặc .0.1 tuỳ mạng nội bộ)
* Còn muốn mở vĩnh viễn thì phải patch romfile.cfg, hoặc làm theo cách mở theo hướng dẫn với modem -NS
---
## 4: <ins>Patch romfile.cfg</ins>
* `romfile.cfg` là file config lấy từ:
```
(Gateway IP) → Maintenance → Backup/Restore
```
* Các thông tin sau được lưu trong file:
  + LOID, mật khẩu LOID
  + SSID, mật khẩu Wi-Fi
  + Cấu hình mạng, firewall, cron, ...
* **Lưu ý:** File chứa nhiều thông tin nhạy cảm (ISP Username, thông tin cấu hình router, ...) nên không share cho bất kì ai ngoài project này nếu bạn cho phép. *Bạn sẽ không biết họ sẽ làm gì với tài khoản PPPoE của bạn đâu...*
### 4.1: Decrypt và chỉnh sửa
* `romfile.cfg` được encrypt bằng bộ mã hoá EVP_aes_256_cbc bởi file `cfg_manager` (dòng -H) và `/userfs/bin/cfg` (dòng -NS)
* Key/IV của 2 dòng đã được reverse. 2 dòng sài 2 key/IV khác nhau
* Có thể giải mã bằng tool trong repo (**Lưu ý: chọn đúng model để decrypt đúng file. Sai sẽ không đọc được**)
* Hướng dẫn sử dụng đã có trong tool, chạy tool với 0 argument sẽ in hướng dẫn
### 4.2: Yêu cầu để sử dụng tool
* Python (đã test từ bản 3.11.6 và có thể chạy từ 3.11.6 đổ lên) và có cài package pycryptodome (pip install pycryptodome)
* *chỉ vậy thôi*
### 4.3: Mở Telnet/SSH vĩnh viễn (*không mất sau reboot nhưng vẫn mất sau khi factory reset.*)
* 1: Decrypt ``romfile.cfg``
* *Note: Nếu đọc file đã decrypt mà xuất hiện các ô ? (<img width="216" height="18" alt="image" src="https://github.com/user-attachments/assets/a164bc82-070f-4669-985d-dc05b7dc02a2" />) như này thì hãy kiểm tra các bước, ưu tiên sử dụng code python chạy local(các tool trên web dễ bị lỗi ) một khi file decrypt lỗi thì không thể xài để backup mà chỉ để đọc thông tin, cần file đầy đủ và không lỗi mới có thể backup lại lên modem ( do sẽ có double check content để xác minh tính hợp lệ )*
* 2: Tìm nơi quản lý Cron (trong file là <Crond>) và thêm
```bash
iptables -F INPUT; iptables -F FORWARD; iptables -F OUTPUT
```
* Trông nó sẽ như thế này (ở đây `/1 * * * *` nghĩa là lệnh sẽ chạy mỗi phút)
```xml
<Crond>
<CommandList Command_0="reboot" Command_1="" Command_2="" Command_3="" Command_4="" Command_5="" Command_6="" Command_7="" Command_8="" /> 
<Entry0 Active="1" NAME="rb" COMMAND="*/1 * * * * iptables -F INPUT; iptables -F FORWARD; iptables -F OUTPUT" />
<Entry1 Active="0" NAME="None" COMMAND="" />
<Entry2 Active="0" NAME="None" COMMAND="" />
<Entry3 Active="0" NAME="None" COMMAND="" />
<Entry4 Active="0" NAME="None" COMMAND="" />
<Entry5 Active="0" NAME="None" COMMAND="" />
<Entry6 Active="0" NAME="None" COMMAND="" />
<Entry7 Active="0" NAME="None" COMMAND="" />
<Entry8 Active="0" NAME="None" COMMAND="" />
</Crond>
```
* Sau đó encrypt lại và upload lên gateway webUI là được
---
## 5: <ins>Debrick với OpenWRT initramfs</ins>
* Khi modem bị brick:
	* 1. Thử reboot, restart boa nếu còn shell.
	* 2. Nếu không truy cập được:
    	* Dùng OpenWrt initramfs để boot tạm (qua UART).
    	* Flash lại các file mtdX.bin từ backup.
    	* Khởi động lại và restore cấu hình (`romfile.cfg`).

* Tham khảo:
	* Đây là link của 1 bản fỉmware openwrt đang được phát triển cho modem VR1200v, chung SoC nên có thể xài được, tuy nhiên không có driver wifi, lan ... và các thành phần tương thích, trong tương lai sẽ mod 1 bản openwrt tương thích sau, hiện tại chỉ để debricking
	* Hãy đọc là làm theo hướng dẫn ( Mục Debricking )
  		```
  		OpenWrt Wiki: TP-Link Archer VR1200v (v2)
  		https://openwrt.org/inbox/toh/tp-link/archer_vr1200v
  		```
* Cảm ơn @cjdelisle (này thua không biết username git của ổng) cho bản initramfs !
* file initramfs tại (cho trường hợp không còn file nữa)
```
https://github.com/Expl01tHunt3r/vnptmodemresearch/blob/main/openwrt-initramfs-en751221/openwrt-en75-en751221-en751221_generic-initramfs-kernel.bin
```
---
## 6: <ins>Decode firmware từ `/tmp/boa-temp`</ins>
* Chạy command sau trong shell của modem
```bash
sed -i '1,$d' /tmp/userdata/auto_dump_boatemp.sh
cat >> /tmp/userdata/auto_dump_boatemp.sh <<'EOF'
#!/bin/sh
out="/tmp/userdata/firm-dump.bin"
echo "[*] Waiting for /tmp/boa-temp to complete upload..."
last_size=0
stable_count=0

while true; do
    if [ -f /tmp/boa-temp ]; then
        set -- $(ls -l /tmp/boa-temp 2>/dev/null)
        size=$5
        if [ "$size" -gt 100000 ]; then
            if [ "$size" -eq "$last_size" ]; then
                stable_count=`expr $stable_count + 1`
            else
                stable_count=0
            fi
            last_size=$size
            if [ "$stable_count" -ge 2 ]; then
                cp /tmp/boa-temp "$out"
                echo "[+] Dumped boa-temp ($size bytes) to $out"
                break
            fi
        fi
    fi
    sleep 1
done
EOF

chmod +x /tmp/userdata/auto_dump_boatemp.sh
```
* Chạy script `/tmp/userdata/auto_dump_boatemp.sh`
* Upgrade firmware như bình thường
* Sau đó quay lại shell, lấy file `/tmp/userdata/firm-dump.bin` rồi có thể dùng `binwalk` hoặc `unsquashfs` để analyze
* **Lưu ý**
	* Có thể sửa file `boa-temp` trong quá trình upgrade để ép flash firmware tùy chỉnh, nhưng rủi ro brick rất cao nếu timing không chuẩn, không biết offset chính xác hay ghi đè file quan trọng.
	* Có thể kích hoạt upgrade thủ công qua việc chỉnh sửa nvram tên fw_upgrade qua tcapi (commit sau khi set) tuy nhiên phải qua được bước check (hiện giờ thì thua).
---
## 7: <ins>ASP Decode (dòng -NS)</ins>
* Trên các dòng firmware model -NS (chưa biết chính xác từ khi nào), các file .asp trong cgi-bin sẽ bị mã hoá, để tiện lợi cho việc mod firmware cần phải decode được file, trong khi nghiên cứu phát hiện file chỉ được mã hoá đơn giản bằng việc đảo bit, có thể decode bằng cách đảo bit lại
* code python để decode asp có trong `tools/asp-decoder.py`, chạy code sẽ có hướng dẫn
* Khi mod file asp, để tương thích với quy trình hoạt động cần phải encode và flash thay vào chỗ file cũ
---
## Cập nhật
* Em đã làm 1 web online để có thể tự giải mã và mã hoá file mà ko cần các bác phải cài này cài nọ https://huggingface.co/spaces/Expl01tHunt3r/file-decoder
	* (hoặc dùng hosting Việt Nam với ping chỉ = 15ms!! https://cfgdecoder.fkrystal.qzz.io) 
* do là free nên sẽ có lúc chập chờn, các bác chịu khó đợi, có thể xem status tại https://stats.uptimerobot.com/U65yw18Rtl
* Hiện đã có key/iv cho dòng NS, đã cải tiến code để có thêm option cho dòng NS
* Xác nhậm tool edit romfile đã chạy được với các model GW020H , GW040H , GW040NS , GW240H
* Đã tìm được cách decode file .asp trong cgi-bin

## Đóng góp:
- Xin cảm ơn 2 bác [@BussyBakks](https://github.com/BussyBakks) và [@AppleSang](https://github.com/AppleSang) đã giúp em nghiên cứu thêm về key cho romfile.cfg dòng modem NS
