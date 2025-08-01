# VNPT GW020H Reverse Engineering & Rooting Project
===================================================

## 1. Mục tiêu dự án
Dự án này tập trung vào nghiên cứu modem **GW020H** (và các model tương tự như GW040H, NS,...):
- Truy cập **root shell** qua mạng LAN, file config hoặc UART.
- Phân tích firmware gốc và các cơ chế bảo mật.
- Hỗ trợ **debrick** thiết bị khi gặp sự cố trong quá trình thử nghiệm.

**⚠️ Miễn trừ trách nhiệm:** 
Tất cả nội dung chỉ nhằm mục đích nghiên cứu, học tập. 
Không khuyến khích sử dụng vào các hoạt động vi phạm pháp luật hay xâm phạm hệ thống mạng. 
Người sử dụng hoàn toàn tự chịu trách nhiệm.

---

## 2. Nội dung trong repo
- `flashdump/mtd0.bin` ... `mtd10.bin`: Dump đầy đủ NAND từ modem firmware gốc v1.
- Bản **OpenWrt initramfs** tương thích SoC: dùng để debrick hoặc mở shell tạm.
- **Tài liệu nội bộ kỹ thuật** VNPT (tham khảo).
- Các script, ghi chú, công cụ root & truy cập shell.
- Dump firmware đã được strip trong `squashfs-modified`:
  - `boa-dump.bin`: firmware gốc ( gw020h ) trong quá trình upgrade qua web UI.
  - `squashfs.image`: phần squashfs đã được tách ( gw020h), có thể giải nén bằng `unsquashfs`.
  - firmware đã dump đc từ boa của gw040h
  - squashfs-root ( đã giải mã ) trong https://github.com/Expl01tHunt3r/vnptgw020h/releases

---

## 3. Hướng dẫn truy cập UART và mở shell

### 3.1 Kết nối UART
- Chuẩn bị USB-UART (khuyến nghị chip CH340) và dây jumper.
- Trên bo mạch gần đèn LED sẽ có 3 chân: `RX`, `TX`, `GND`.
- Kết nối đúng để tránh hỏng phần cứng.
- Lưu ý đảm bảo kết nối tốt dây ( có thể hàn nếu muốn )

### 3.2 Mở nguồn và đăng nhập
- Khi boot hay khi telnet/ssh, sẽ thấy :
  ```
  Please press Enter to activate this console.
  ```
  - Lưu ý nhỏ: bản ssh được xài khá cố nên các bác phải bật option insecure mới kết nối đc, và muốn dùng telnet/ssh thì phải sửa file romfile.cfg bằng tool và upload lại để mở firewall ( iptables )
- Nhấn Enter, màn hình hiện `tc login:`.
- Các tài khoản:
  - admin / VnT3ch@dm1n
  - operator / VnT3ch0per@tor
  - customer / customer (quyền thấp)
- Đăng nhập thành công: chạy `uname -a` để kiểm tra hệ thống.

### 3.3 Mở Telnet tạm thời (tùy chọn)
```
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
```
Sau đó có thể telnet tới 192.168.1.1 (hoặc SSH nếu hệ thống hỗ trợ).
Nếu muốn mở telnet/ssh vĩnh viễn, hãy tới mục Patch romfile.cfg

---

## 4. Boot OpenWrt initramfs (tùy chọn)
Xem mục "BOOT WRT" trong thư mục `doc`.

---

## 5. Ghi chú kỹ thuật

- SoC: **MediaTek EN751221**
- Flash: **128MB SPI NAND** (F50L1G41LB hoặc tương đương, có nhiều loại nand và SoC đc hỗ trợ bởi firmware này, có thể thấy trong /userfs/profile.cfg)
- Dump NAND:
  - Có thể dùng `cat /dev/mtdX` trong firmware gốc của vnpt hoặc `nanddump` từ OpenWrt initramfs.
- Các tài liệu nội bộ đã có sẵn trong thư mục `doc`.
- **Firmware**: hiện chưa có cách giải mã trực tiếp ngoài việc dump `boa-temp`.

---

## 6. Patch romfile.cfg

### 6.1 Giới thiệu
- `romfile.cfg` là file backup config từ:
  ```
  192.168.1.1 → Maintenance → Backup/Restore
  ```
- Nội dung gồm:
  + LOID, mật khẩu LOID
  + SSID, mật khẩu Wi-Fi
  + Cấu hình mạng, firewall, cron, ...
- **Lưu ý:** Không nên chia sẻ file này vì chứa thông tin nhạy cảm.

### 6.2 Giải mã & chỉnh sửa
- File mã hóa bằng `cfg_manager` trong firmware.
- Key/IV chung cho các modem GW đã được reverse.
- Có thể giải mã, chỉnh sửa và mã hóa lại bằng `tools/romfileedit.py`.
- Tải thư viện cần thiết và nhập lệnh `python3 romfileedit.py` trên CMD ( Windows ) hay bất cứ shell nào đã có python.
- Đã có hdsd code , chỉ cần chạy là có, em viết bằng tiếng anh do tiếng việt lỗi front.

### 6.3 Yêu cầu
- Python + các thư viện hỗ trợ.
- Sau khi chỉnh sửa, mã hóa lại rồi upload qua giao diện web để áp dụng.
### 6.4 Mở telnet/ssh vĩnh viễn ( không mất sau reboot nhưng vẫn mất sau factory reset )
- giải mã file romfile.cfg, tìm tới nơi quản lý cron, chèn thêm task cron mới với lệnh iptables -P INPUT ACCEPT ; iptables -P FORWARD ACCEPT ; iptables -P OUTPUT ACCEPT
- cho chạy mỗi phút hoặc tuỳ sở thích, trông nó như này ( các bác nhớ sửa cho nó active = 1 )
```
<Crond>
	<Entry0 Active="1" NAME="rb" COMMAND="*/1 * * * * iptables -F INPUT; iptables -F FORWARD; iptables -F OUTPUT" />
	<Entry1 Active="0" NAME="None" COMMAND="" />
	<Entry2 Active="0" NAME="None" COMMAND="" />
	<Entry3 Active="0" NAME="None" COMMAND="" />
	<Entry4 Active="0" NAME="None" COMMAND="" />
	<Entry5 Active="0" NAME="None" COMMAND="" />
	<Entry6 Active="0" NAME="None" COMMAND="" />
	<Entry7 Active="0" NAME="None" COMMAND="" />
	<Entry8 Active="0" NAME="None" COMMAND="" />
	<CommandList Command_0="reboot" Command_1="" Command_2=""
Command_3="" Command_4="" Command_5=""
Command_6="" Command_7=""
Command_8="" />
</Crond>
```
- Sau đó mã hoá lại rồi up lên lại là xong


---

## 7. Debricking với OpenWrt (BOOT WRT)
- Khi modem bị brick:
  1. Thử reboot, restart boa nếu còn shell.
  2. Nếu không truy cập được:
     - Dùng OpenWrt initramfs để boot tạm (qua UART).
     - Flash lại các file mtdX.bin từ backup.
     - Khởi động lại và restore cấu hình (`romfile.cfg`).

- Tham khảo:

  -Đây là link của 1 chương trình openwrt đang dc phát triển cho modem VR1200v, nói chung là ko liên quan lắm nhưng chung soc nên dùng qua lại đc, mỗi tội ko có driver wifi, lan ... các thứ tương thích ko đc nên chịu, em sẽ cố làm 1 bản openwrt tương thích sau, nói chung giờ dùng chủ yếu để debricking nếu các bác có lỡ .... =))))
  ```
  OpenWrt Wiki: TP-Link Archer VR1200v (v2)
  https://openwrt.org/inbox/toh/tp-link/archer_vr1200v
  ```

---

## 8. Giải mã firmware qua boa-temp

Chạy lệnh trong shell của modem:

```
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

### Các bước tiếp theo
1. Chạy script:
   ```
   sh /tmp/auto_dump_boatemp.sh
   ```
2. Đăng nhập web UI, upload file firmware cần dump và bấm **Upgrade**.
3. Quay lại shell, kiểm tra `/tmp/yaffs/boa-dump.bin`.
4. Tải file về (ví dụ qua tftp).
5. Dùng `binwalk` hoặc `unsquashfs` để phân tích.

**Lưu ý:**  
Có thể sửa file `boa-temp` trong quá trình upgrade để ép flash firmware tùy chỉnh, 
nhưng rủi ro brick rất cao nếu timing không chuẩn.

**Chú thích**
- em đang phân tích cfg_manager thêm để có public key decrypt firmware mà ko cần thông qua dump nhưng mà chắc mất kha khá thời gian để có bản phần mềm, phần mềm này cũng là cái quản lý file romfile.cfg ( e cũng trích xuất key với iv giải mã từ chỗ này ), bác nào cần e sẽ upload lên để phân tích chung. Em cũng đang xem xét việc làm bản .exe ( cho win ) và .app cho Mac, tự động để tải , edit, rồi upload lên mà ko cần tự thao tác, nhma chưa có thời gian, bác nào rành có thể làm giúp em với ạ
- Lưu ý nhỏ cho các bác phân tích file cfg_manager thì nên nên load vào đủ lib cho nó phân tích chính xác ( các bác cứ tìm trong squashfs-root )

---
