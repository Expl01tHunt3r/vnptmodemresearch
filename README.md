<h1 align="center">VNPT Reverse Engineering & Rooting Project</h1>

***<h4 align="center">Không gì là không thể :)</h4>***

## 1: <ins>Mục tiêu</ins>
* Nghiên cứu về các modem nhà mạng 4 chữ (VNPT) (hiện tại đang nghiên cứu các dòng -H, -NS, -XS
* Phá firmware, tìm hiểu cơ chế encryption trong firmware (nếu ra và rảnh thì cố mod OpenWRT qua luôn)
* Vọc vạch hỏng modem thì có file để debrick (hiện tại chỉ có thể debrick cho dòng -H, -NS)
  
> [!CAUTION]
> **⚠️ Miễn trừ trách nhiệm ⚠️**<br>
> Tất cả nội dung chỉ nhằm mục đích nghiên cứu, học tập.<br>
> Không khuyến khích sử dụng vào các hoạt động vi phạm pháp luật hay xâm phạm hệ thống mạng.<br>
> Người sử dụng hoàn toàn tự chịu trách nhiệm.

#### Mong được các anh dev bên VNPT chiếu cố.
---
## 2: <ins>Content</ins>
* [`flashdump/*`](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/main/flashdump) NAND dump của firmware model GW-020H (sắp tới sẽ cập nhật thêm -XS, -NS)
* [`openwrt-initramfs-en751221/*`](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/main/openwrt-initramfs-en751221) dùng để debrick nếu vọc vạch cháy firmware
* [`tools/*`](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/main/tools) các tool để decrypt và encrypt romfile.cfg
* Sắp tới sẽ cập nhật tool encrypt, decrypt cho dòng -XS (050)
* [`decrypted-cfgfile-xs/*`](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/decrypted-cfgfile-xs) các mẫu file romfile.cfg của model đã decrypt
*  [`private-romfile-key/*`](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/private-romfile-key) cert và private key cho decrypt và encrypt file .cfg model -XS
* Dump firmware đã được strip trong [`squashfs-modified`](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/main/squashfs-modified):
	* `boa-dump.bin`: firmware gốc (GW020-H) trong quá trình upgrade qua web UI.
	* `squashfs.image`: phần squashfs đã được tách (GW020-H), có thể giải nén bằng `unsquashfs`.
	* Firmware đã dump đc từ boa của GW040-H
	* squashfs-root(đã giải mã) tại [đây](https://github.com/Expl01tHunt3r/vnptmodemresearch/releases)
 *  [`Integrations/*`](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/Integrations) Hướng dẫn và tài nguyên, lệnh cài các phần mềm bổ sung, patch,...
---
## 3: <ins>Shell và những người bạn (TTY, SSH, ...)</ins>
* Mục này sẽ hướng dẫn mở shell (console) của router, nếu đã có thì bỏ qua, còn chưa thì tiếp~~
> [!WARNING]  
> **⚠️ CẢNH BÁO ⚠️**  
> Việc mở shell có thể vô tình tạo ra lỗ hổng ngay trên hệ thống mạng của bạn!  
> Hãy chắc chắn rằng chỉ có **BẠN** được phép truy cập vào.  
> Bằng việc bạn đặt mật khẩu đăng nhập vào WiFi khó đoán!
> Hãy sử dụng passwd và đổi pass ngay sau khi vào shell (nhớ đổi cho tất cả tài khoản), nếu không có thể thiết lập whitelist được quyền truy cập

### 3.1: UART
*Nếu bạn không thể kết nối qua UART cũng đừng lo, có cách không phải con thiệp phần cứng mà vẫn vào được shell cho cả dòng -H, -NS, -XS
* Chuẩn bị USB-UART (khuyến nghị chip CH340 hoặc FT232BL cho mấy khứa đỗ nghèo khỉ) và dây jumper.
* Trên bo mạch gần đèn LED sẽ có 3 chân: `RX`, `TX`, `GND`.
* Kết nối đúng để tránh hỏng phần cứng (tự google xem hướng dẫn đi).
* Lưu ý đảm bảo kết nối tốt dây (có thể hàn cho lành)
### 3.2: Tài khoản login
* Khi boot lên và truy cập bằng uart sẽ thấy :
  ```txt
  Please press Enter to activate this console.
  ```
* **Lưu ý**:
  - Nếu bạn kết nối SSH, bản SSH được xài cực cổ lỗ sĩ nên phải bật option insecure mới kết nối được (với dòng GW020H sử dụng firmware cũ), và muốn dùng telnet/ssh thì sửa file romfile.cfg bằng tool và upload lại để mở firewall (với dòng H), đừng lo, nếu bạn không muốn sửa romfile.cfg thì còn cách khác !
  - Với model -NS, -XS: (Nếu bạn quên/không biết password web quản trị) Nhấn nút WPS trước và ấn nút Reset sau khi đang nhấn giữ WPS, sau khi nhấn cả hai nút trong tầm 5-6s đèn PON sẽ nhấp nháy là đã mở Telnet thành công. Nếu đang ấn mà đèn LOS nhấp nháy đỏ lên thì **NGAY LẬP TỨC** thả các nút ra và chờ router reboot và thực hiện lại, nhớ backup trước khi mở để tránh nhấn quá thời gian gây reset.
  - Cách 3 (nếu bạn nhớ/biết password đăng nhập web quản trị) Bạn hãy tìm tới mục ACL và tắt nó đi ... thế là xong rồi.
* Nếu đã mở telnet và connect vào thì sẽ có: `tc login:`
* Các credential cho -H, -NS:
  * admin / VnT3ch@dm1n (như root do full quyền,telnet,ssh,ftp)
  * operator / VnT3ch0per@tor (only UART)
  * customer / customer (quyền thấp,telnet,ssh)
  * user3 / star ( web, disable by default, quyền thấp, model -NS)
* Riêng cho dòng -XS
  * customer / customer (quyền thấp, telnet)
  * admin / $2$7c1ae60c120167530ca98a32c5323d9b89cff5bb (hash, chưa tìm ra pass chính xác, telnet, console, ftp) ( `1234` , `s2@We3%Dc#` , `admin4444` )
  * operator / $1$y....DM.$7eLwNxxQmjB1WmfB.ancV/ (hash, chưa tìm ra pass chính xác, web) (`oper@tor`)
  * user3 / star ( web, disable by default, quyền thấp)

* Khi đăng nhập thành công sẽ vào trực tiếp shell mặc định (BusyBox Shell),nhắc lại một lần nữa, bạn nên đổi mật khẩu bằng **passwd** để tránh người khác có thể vào được shell.
### 3.3: Telnet/SSH tạm thời (nếu đang sài UART)
* Gõ 3 lệnh sau vào terminal
```bash
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
```
hoặc muốn mở mỗi port SSH thì...
(Hoặc nếu bạn nhập 3 câu trên nhưng không mở port SSH thì câu dưới nó hoạt động - Xác nhận chạy trên GW040-NS)
```
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
```
* Xong connect bằng IP gateway (.1.1 hoặc .0.1 tuỳ mạng nội bộ) qua shell của máy bạn, có thể dùng telnet hoặc ssh tuỳ bạn muốn
```
ssh [user]@[gateway-ip]
```
* Nếu muốn mở telnet/ssh lâu dài, hãy tới mục [3.2: Tài khoản login] và kéo xuống một chút (đối với người mở shell qua UART).
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
* File cfg đã decrypt của dòng XS có thể tìm thấy trong data của repo này
### 4.1: Decrypt và chỉnh sửa
* `romfile.cfg` được encrypt bằng bộ mã hoá EVP_aes_256_cbc bởi binary `cfg_manager` (dòng -H) và `/userfs/bin/cfg` (dòng -NS,-XS)
* Key/IV của 2 dòng -H và -NS đã được reverse. 2 dòng sài 2 key/IV khác nhau riêng đối với dòng -XS sử dụng PKCS7 với private key đã được dump (chi tiết xem trong code dùng để decrypt/encrypt romfile )
* Có thể giải mã bằng tool trong repo (**Lưu ý: chọn đúng model để decrypt đúng file. Sai sẽ không đọc được, model cho dòng XS đang được code, xài tạm command trên máy để thay thế !**)
* Cách này còn có thể sử dụng để thêm script autostartup mà không phải cài patch (tuy nhiên chỉ hiệu quả với dòng -H do dòng -NS có cơ chế kiểm tra file backup khá nghiêm nên sẽ không chấp nhận file backup sau chỉnh sửa, dòng -XS cũng có cách để pack lại sau edit
	+ Cụ thể, với dòng -XS sau khi tải romfile.cfg từ webui thì có thể dùng command ( cài openssl ) hoặc tool python ( dùng cho trường hợp lấy config từ các dump mtd ) để decrypt
```bash
openssl smime -decrypt -inform DER -in path/to/romfile.cfg -out /whatever/romfile.cfd.dec -inkey path/to/romfile_encrypt_privatekey.pem
```

   + File privatekey.pem trên đã được up trong repo, lưu ý trỏ tới đúng file
   + Sau khi chỉnh sửa xong ( bạn có thể thay hash của các tài khoản để đặt lại mật khẩu tuỳ thích, đây chính là cách để có được admin shell trên model -XS hiện tại ), tool để gen hash đã có trong tools của repo này ), sau đó bạn phải pack ( encrypt ) lại file .cfg bằng lệnh
```bash
openssl smime -encrypt -inform DER -outform DER \
  -in /path/to/modified/romfile.cfg \
  -out /whatever/path/tp/outfile/romfile.cfg \
  /path/to/romfile_encrypt_cert.pem
```
   + file cert.pem trên là public key tương ứng với private key, có sẵn trong modem, hiện đã up lên repo này, bạn có thể tìm tại cùng thư mục với private key 
   + Xong! bạn có thể upload file backup và enjoy !

* Hướng dẫn sử dụng đã có trong tool, chạy tool với argument trống sẽ in hướng dẫn
### 4.2: Yêu cầu để sử dụng tool
* Python (đã test từ bản 3.11.6 và có thể chạy từ 3.11.6 đổ lên, thực ra hầu hết các bản mới đều có thể chạy được) và có cài package pycryptodome `pip install pycryptodome`
* *chỉ vậy thôi*
### 4.3: Mở Telnet/SSH bằng cách edit romfile.cfg (*không mất sau reboot nhưng vẫn mất sau khi factory reset, dành cho dòng -H, -XS *)
* 1: Decrypt ``romfile.cfg``
* *Note: Nếu đọc file đã decrypt mà xuất hiện các ô ? (<img width="216" height="18" alt="image" src="https://github.com/user-attachments/assets/a164bc82-070f-4669-985d-dc05b7dc02a2" />) như này thì hãy kiểm tra các bước, ưu tiên sử dụng code python chạy local(các tool trên web dễ bị lỗi ) một khi file decrypt lỗi thì không thể xài để backup mà chỉ để đọc thông tin, cần file đầy đủ và không lỗi mới có thể backup lại lên modem ( do sẽ có double check content để xác minh tính hợp lệ )*
* 2 (-H): Tìm nơi quản lý Cron (trong file là \<Crond\>) và thêm
```bash
iptables -F INPUT; iptables -F FORWARD; iptables -F OUTPUT
```
Hoặc (trong trường hợp dấu ";" bị đánh là không hợp lệ )
```bash
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
```
Ngoài lệnh này mọi người có thể thêm các lệnh khác nếu muốn.

* *Note1: Riêng đối với -XS, bạn có thể mở telnet bằng cách thay giá trị Active của các tài khoản là Yes, thông thường sẽ được active sẵn, bạn chỉ cần tắt ACL hoặc bấm nút như đã hướng dẫn, nếu không muốn thì hãy đăng nhập vào web quản trị và đi tới url `telnet.cgi` hoặc `telnet.asp` rồi chỉnh sang hoạt động.

*Tiếp ... nếu bạn đang làm trên model -H

* Trông nó sẽ như thế này (ở đây `/1 * * * *` nghĩa là lệnh sẽ chạy mỗi phút)
```xml
<Crond>
<CommandList Command_0="reboot" Command_1="" Command_2="" Command_3="" Command_4="" Command_5="" Command_6="" Command_7="" Command_8="" /> 
<Entry0 Active="1" NAME="rb" COMMAND="*/1 * * * * iptables -I INPUT -p tcp --dport 22 -j ACCEPT" />
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
	* Thử reboot (busybox reboot), restart boa nếu còn shell.
 	* Thử tắt bằng nút nguồn của router và bật lại
	* Nếu không truy cập được shell nốt:
 		* Mở nguồn cho modem
    	* Dùng OpenWrt initramfs để boot tạm (qua UART).
    	* Flash lại các file mtdX.bin từ backup.
    	* Khởi động lại và restore cấu hình (`romfile.cfg`), hoặc nếu muốn chắc hơn thì hãy tải lại firmware và update qua webUI 1 lần nữa.

* Tham khảo:

  * Dưới đây là link của 1 bản firmware OpenWRT đang được phát triển cho modem VR1200v, chung SoC nên có thể xài được, tuy nhiên không có driver WiFi ,Lan...
  * Trong tương lai sẽ mod 1 bản OpenWRT tương thích sau, hiện tại chỉ để debrick.
  * Hãy đọc và làm theo hướng dẫn tại mục [Debricking](https://openwrt.org/inbox/toh/tp-link/archer_vr1200v#debricking) của Router TP-Link Archer VR1200v đến từ OpenWRT.

 * Cảm ơn [@cjdelisle](https://github.com/cjdelisle) cho bản [initramfs](https://github.com/Expl01tHunt3r/vnptmodemresearch/blob/main/openwrt-initramfs-en751221/openwrt-en75-en751221-en751221_generic-initramfs-kernel.bin)!
 * Hiện tại chưa xác định chính xác nhưng khả năng model XS lấy nền firmware từ 1 nhà sản xuất Trung Quốc: baidu (?)
---
## 6: <ins>Decode firmware từ `/tmp/boa-temp`</ins>
<details>
<summary>Chạy lệnh trong shell của modem(click to expand)</summary>
	
```shell
sed -i '1,$d' /tmp/auto_dump_boatemp.sh
cat >> /tmp/auto_dump_boatemp.sh <<'EOF'
#!/bin/sh
out="/tmp/yaffs/boa-dump.bin"
mkdir -p /tmp/yaffs

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

            # Nếu không đổi 2 lần liên tiếp (2 giây) => upload xong
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

chmod +x /tmp/auto_dump_boatemp.sh
```
</details>

> [!NOTE]
> Trong dòng -NS thì sẽ không có mount phân vùng tên yaffs nên khi chạy script đó trên dòng -NS thì file đã dump vẫn sẽ bị mất khi upgrade xong  
> Khuyên đổi cái output path từ `/tmp/yaffs/*` qua `/tmp/userdata/*` nếu chạy trên dòng -NS,-XS

* Chạy script `/tmp/auto_dump_boatemp.sh`
* Upgrade firmware như bình thường
* Sau khi reboot xong, quay lại shell, lấy file `/tmp/userdata/boa-dump.bin` (`/tmp/yaffs/boa-dump.bin` nếu dòng -H) rồi có thể dùng `binwalk` hoặc `unsquashfs` để analyze
* **Lưu ý**
	* Có thể sửa file `boa-temp` trong quá trình upgrade để ép flash firmware tùy chỉnh, nhưng rủi ro brick rất cao nếu timing không chuẩn, không biết offset chính xác hay ghi đè file quan trọng.
	* Có thể kích hoạt upgrade thủ công qua việc chỉnh sửa nvram tên fw_upgrade qua tcapi (commit sau khi set) tuy nhiên phải qua được bước check firmware có hợp lệ không (hiện giờ thì thua).
---
## 7: <ins>ASP Decode (dòng -NS)</ins>
* Trên các dòng firmware model -NS,-XS (chưa biết chính xác từ bản firm nào), các file .asp trong cgi-bin sẽ bị mã hoá, để tiện lợi cho việc mod firmware hay muốn đọc logic flow cần phải decode được file, trong khi nghiên cứu phát hiện file chỉ được mã hoá đơn giản bằng việc đảo bit, có thể decode bằng cách đảo bit lại.
* Code python để decode asp có trong `tools/asp-decoder.py`, chạy code sẽ có hướng dẫn.
* Khi mod file ASP, để tương thích với quy trình hoạt động cần phải encode và flash thay vào chỗ file cũ.
---
## 8: <ins>Ứng dụng</ins>
* [AdGuardHome](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/Integrations/AdGuard)
* [ddns-updater](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/Integrations/ddns_updater)
* Caddy (In progress)
* [Btop](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/Integrations/btop)
> Đã có hướng dẫn cài trong README của các phần ứng dụng
---
## 9: Patch ( Với các dòng NS )
* [autorun](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/Integrations/autorun)
* [myshell](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/Integrations/myshell) 
---
## 10: <ins>Thảo luận</ins>
* [VOZ](http://voz.vn/t/vnptmodemresearch-%E2%80%94-nghien-cuu-firmware-root-modem-vnpt-can-anh-em-chung-tay.1159218)
* [Github](https://github.com/Expl01tHunt3r/vnptmodemresearch/discussions/10)
* ~~Discord~~
---
## 11: <ins>Những mục tiêu sắp tới</ins>
* Cài được OpenWRT
* Tuỳ chỉnh chức năng cho nút WPS/WLan có những tính năng khác (Như lấy IP mới trong vòng 5s,...)
* Dễ dàng điều khiển led để báo hiệu những thông tin khác (Như mức sử dụng CPU, cảnh báo khi gần hết RAM,...)
* Cài được một loại VPN nào đó
* Optimize để đạt hiệu năng router tốt hơn (Ép xung, loại bỏ tính năng thừa,...)
* Custom được firmware để dễ dàng phát triển hơn (Như custom Web-UI, thêm bớt tính năng)
## Cập nhật
* Em đã làm 1 web online để có thể tự giải mã và mã hoá file mà không cần các bác phải cài này nọ tại [đây](https://huggingface.co/spaces/Expl01tHunt3r/file-decoder)
	* (hoặc dùng hosting Việt Nam với ping chỉ = 15ms!! -> https://cfgdecoder.fkrystal.qzz.io) 
* Do là free nên sẽ có lúc chập chờn, các bác chịu khó đợi, có thể xem status tại [đây](https://stats.uptimerobot.com/U65yw18Rtl)
* Hiện đã có key/iv cho dòng NS, đã cải tiến code để có thêm option cho dòng NS
* Xác nhận tool edit romfile đã chạy được với các model [GW020-H](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw020-h), [GW240-H](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw240-h), [GW040-H](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-h), [GW040-NS](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-ns) và command chạy được với model [GW050-XGS](https://www.vnpt-technology.vn/vi/product_detail/xgs-pon-ont-igate-xsw050-ns)
* Đã tìm được cách decode file .asp trong cgi-bin
* Các file cfg trên model có cấu trúc như sau nén gzip->header HD3R,version,length,...(256bytes)->data encrypt by PKCS7 structure

## Đóng góp:
- Xin cảm ơn 2 bạn [@BussyBakks](https://github.com/BussyBakks) và [@AppleSang](https://github.com/AppleSang) đã giúp em nghiên cứu thêm về key cho romfile.cfg dòng modem NS và cài các ứng dụng

<p align="center">Made with ❤️ by Expl01tHunt3r</p>
