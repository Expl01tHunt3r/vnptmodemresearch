<h1 align="center">AdGuardHome Installer</h1>
<h4 align="center">nhưng là cho dòng 4 chữ~</h4>

> [!NOTE]
> Chúng mình không phải dev trong project AdGuardHome  
> Nên tất cả các assets (ảnh, file, ...) liên quan đều được đánh bản quyền bởi các dev của AdGuardHome

## 1: <ins>Yêu cầu</ins>
<img src="https://avatars.githubusercontent.com/u/30082422" width="128" height="128" alt="adguard" align="right" />

* Mở được Telnet/SSH trên router đã đề cập ở [ngoài kia](https://github.com/Expl01tHunt3r/vnptmodemresearch?tab=readme-ov-file#3-shell-v%C3%A0-nh%E1%BB%AFng-ng%C6%B0%E1%BB%9Di-b%E1%BA%A1n-tty-ssh-)
* Có hiểu biết về networking và biết ứng phó những lỗi xảy ra
* Phải có thông tin gateway WebUI để setup

> [!CAUTION]
> **Bạn sẽ tự chịu hết các hậu quả đi kèm nếu làm theo!!!**  
> **Và chúng mình KHÔNG CHỊU TRÁCH NHIỆM nếu bị lỗi trên router nhà bạn**  
> *đã nhắc rồi nhé.*

> [!WARNING]
> Hiện tại chỉ có dòng [GW040-NS](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-ns) đã confirm chạy okay  
> Còn dòng -H có lỗi reboot sau khi chạy script, chúng mình vẫn đang nấu vụ đó, mà ai có dòng -H có thể liên hệ [Discord](https://discordapp.com/users/1086149348414464041) để góp vui :)

## 2: <ins>Cài Đặt</ins>
* SSH/Telnet vào router
<img width="469" height="146" alt="image" src="https://github.com/user-attachments/assets/cde8d9f6-be70-44d9-86bd-41d13cd54da5" />

* Paste lệnh dưới vào shell
```sh
cd /tmp/userdata/ && /userfs/bin/curl -s -k -o AdGuard.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/main/AdGuard/install-ns.sh && chmod +x AdGuard.sh && sh AdGuard.sh
```

* Hãy **CHẮC CHẮN** đọc hết phần text trước khi bấm **Enter** *(nếu hiểu thì thôi .-.)*
<img width="982" height="512" alt="image" src="https://github.com/user-attachments/assets/ca525647-5626-486e-a237-7425d160a51f" />

* chờ....
* chờ....
* Để ý ```Bạn Vào Trang http://192.168...```. Muốn tiếp thì vào đó và tiếp tục mục 3
> Đóng shell hiện tại để nó chạy nền. Cần làm tiếp thì cứ SSH/Telnet bằng session khác.
<img width="977" height="512" alt="image" src="https://github.com/user-attachments/assets/83374ff7-cb10-41dc-9b3e-e4ada4701c39" />

## 3: <ins>AdGuardHome</ins>
* Chạy xong script trên kia, connect vào `http://[gateway-ip]:3000`  
* Xong nếu hiện ra như dưới, bấm `Bắt Đầu`
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/37f99b39-eacc-438a-bda4-18c7ef6a0ff4" />

* Chọn port cho AdGuardHome WebUI (khác port 80 và 443 là được) <br>
 *ở đây sài 88*
<img width="1366" height="768" alt="hideip" src="https://github.com/user-attachments/assets/bd6c3c20-6a75-4ab5-810f-1fd3472f96cb" />


* Thiết lập account quản trị của AdGuardHome (giống của WebUI cũng được) 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/5c31d559-8cc8-4bdd-bced-3c77ad7d71b7" />

* Ấn ```Tiếp -> Tiếp -> Mở Bảng Điều Khiển```. Tới đây đóng tab được rồi, tinh chỉnh để sau
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/9a8792c2-c2d3-4db9-8c37-e770308dd6d9" />

## 4: <ins>Quay DNS</ins>
* Vào WebUI  
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/7a6a5ea0-7edc-488f-9211-5007ddc9eff7" />

* Bấm ```Network -> LAN```
<img width="1293" height="138" alt="image" src="https://github.com/user-attachments/assets/6f84ff0b-a85d-4c7d-874a-f77686e58129" />

* Setup DNS như hình dưới (`8.8.8.8` có thể thay bằng các DNS bên thứ 3 (Cloudflare, ...))
<img width="611" height="101" alt="image" src="https://github.com/user-attachments/assets/f7b939bd-cbb0-4bb1-9a7e-9d1eb423b734" />

* Bấm ```Save``` dưới cùng để lưu
* Thế là xong. Còn setup AdGuardHome này nọ thi mời lên Google, nói ở đây thì dài lắm
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/65ca3512-f326-404f-a05b-689a662a64ab" />

## 5: <ins>"Mất Điện"</ins>
> Mời đọc [FAQ](https://github.com/Expl01tHunt3r/vnptmodemresearch/blob/main/AdGuard/README.md#6-faqs) sẽ hiểu tại sao có mục này
* SSH/Telnet vào router
<img width="456" height="133" alt="image" src="https://github.com/user-attachments/assets/551a9f3e-c71c-4d89-b95a-c597a9e4d88f" />

* Paste lệnh vào shell
```sh
/tmp/userdata/AdGuard/AdGuard.sh
```
* Nó sẽ tự cài lại cho
<img width="969" height="503" alt="image" src="https://github.com/user-attachments/assets/2cecc5f5-adb1-4203-a51c-14a3d30f1bd5" />

* Xong tắt SSH/Telnet (đừng Ctrl+C, dùng nút X kia)

## 6: <ins>FAQs</ins>
* **?: Tại sao phải chạy lại script sau mất điện?**
  * Tất cả các file (trừ config) đều lưu tại `/tmp/SafeGate`, mà nó lại là `tmpfs` nên sau khi reboot (mất điện) thì nó trắng bóc, không còn cái gì cả nên chạy lại để nó tự cài lại cho  
* **?: Số liệu (size blocked, ...) của AdGuardHome đều set 0 khi reboot?**
  * Như trên, tất cả (trừ config) đều trắng bóc khi reboot (mất điện)
  > Chi tiết hơn: Là chỗ lưu /tmp/userdata/AdGuard/data nó không hỗ trợ nmap(2) vì format không hỗ trợ, cần bạn nào tìm hiểu phương pháp lưu các file database!  
* **?: Tại sao phải set `Secondary DNS` là DNS bên thứ 3?**
  * Nếu chưa kịp cài lại và không set `Secondary DNS` thì router sẽ không có DNS để quay dịch domain, đồng nghĩa là bạn ***mất kết nối*** với internet. Vì thế nên để `Secondary DNS` thành bên DNS thứ 3 để tránh trường hợp quên chạy lại AdGuardHome thì vẫn có cái mà dùng  
* **?: Ở chỗ [Quay DNS](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/main/AdGuard#2-quay-dns) tại `Secondary DNS` có thể gắn DNS khác không?**
  * Yep!
* **?: Không block ads trên điện thoại được với AdGuardHome?**
  * Vào `Cài Đặt -> Kết Nối -> Cài Đặt Kết Nối Khác`, chỉnh `DNS Riêng Tư` thành `Tắt`
  > Đấy là cách chỉnh dựa trên điện thoại Samsung, các điện thoại Android khác lẫn IPhone cũng sẽ có cách  
  > Cứ tra google là được mà  
* **?: Chỗ `Máy Chủ DNS` mà nó báo `Port 53 đã bị sử dụng`?**
  * Mở shell và nhập `kill -9 $(pidof dnsmasq)` xong reload và tiếp tục 
* **?: "Vấn đề khác của AdGuardHome mà trên kia không có!"**
  * Tạo [Issue](https://github.com/Expl01tHunt3r/vnptmodemresearch/issues) với title có đề `[AdGuard]` đầu để hỗ trợ
<img width="27" height="27" align="left" alt="image" src="https://www.vnpt-technology.vn/front/images/favicon.png" /> 
<h4 align="center">The End</h4>
<h6 align="right">AppleSang With 🍎</h6>
<h6 align="right">Edited by BussyBakks with my ass</h6>








