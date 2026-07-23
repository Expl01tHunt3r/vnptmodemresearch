<h1 align="center">AdGuardHome</h1>
<h4 align="center">nhưng là cho dòng 4 chữ~</h4>
<h6 align="left">AppleSang, D:22/M:07/Y:2026</h6>
<h6 align="left">BussyBakks, D:11/M:01/Y:2026</h6>
<img width="27" height="27" alt="image" align="right" src="https://github.com/user-attachments/assets/de8413fe-b942-487b-a6d8-3f5111d292c9" />

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
> **Hãy đọc hết file ReadMe này một lần rồi mới bắt tay vào làm**   
> *đã nhắc rồi nhé.*



> [!WARNING]
> Hiện tại chỉ có dòng [GW040-NS](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-ns) đã confirm chạy okay  
> Còn dòng -H có lỗi reboot sau khi chạy script, chúng mình vẫn đang nấu vụ đó, mà ai có dòng -H có thể liên hệ [Discord](https://discordapp.com/users/1086149348414464041) để góp vui :)

## 2: <ins>Cài Đặt</ins>
* SSH/Telnet vào router  
<img width="469" height="146" alt="image" src="https://github.com/user-attachments/assets/cde8d9f6-be70-44d9-86bd-41d13cd54da5" />

* Paste lệnh dưới vào shell
```sh
cd /tmp/ && /userfs/bin/curl -s -k -o AdGuard.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/master/Integrations/AdGuard/install/ns.sh && chmod +x AdGuard.sh && sh AdGuard.sh
```

* Hãy **CHẮC CHẮN** đọc hết phần text trước khi bấm **Enter** *(nếu hiểu thì thôi .-.)*
<img width="982" height="512" alt="image" src="https://github.com/user-attachments/assets/ca525647-5626-486e-a237-7425d160a51f" />

* chờ....
* chờ....
* Để ý ```http://192.168...```. Muốn tiếp thì vào đó và tiếp tục mục 3
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
> [!WARNING]
> Hiện script đã có thể tự set IP Gateway vào chỗ DNS nhưng bạn cũng nên check xem đã đúng chưa

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
> [!CAUTION]
> **Bạn chỉ đọc cái này khi mà AdGuardHome không hoạt động sau khi mất điện**  
> Mời đọc [FAQ](https://github.com/Expl01tHunt3r/vnptmodemresearch/blob/main/AdGuard/README.md#6-faqs) sẽ hiểu tại sao có mục này
* SSH/Telnet vào router
<img width="456" height="133" alt="image" src="https://github.com/user-attachments/assets/551a9f3e-c71c-4d89-b95a-c597a9e4d88f" />

* Paste lệnh vào shell
```sh
/tmp/userdata/AdGuard/startup.sh
```
* Nó sẽ tự cài lại cho
<img width="969" height="503" alt="image" src="https://github.com/user-attachments/assets/2cecc5f5-adb1-4203-a51c-14a3d30f1bd5" />

* Xong tắt SSH/Telnet (đừng Ctrl+C, dùng nút X kia)

## 6: <ins>DHCP và bye bye dnsmasq</ins>

* Ngay tại trang chủ chính của AdGuardHome bạn vào `DHCP Settings`

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/65913fa1-2fd2-437e-95ab-118a95e1ea8e" />

* Setup những giá trị như trong ảnh

<img width="1104" height="380" alt="image" src="https://github.com/user-attachments/assets/8afdc0dc-8487-41db-aad3-839b7bed6363" />

> Bạn có thể set tuỳ ý nhưng phải biết mình đang làm gì

* Tiếp đến bạn bấm `Check for DHCP server`

  > Tuy sẽ hiện cảnh báo đỏ nhưng bạn cứ mặc kệ đi

* Cuối cùng là bấm `Enable DHCP server`


## 7: <ins>FAQs</ins>
* **?: Số liệu (size blocked, ...) của AdGuardHome đều set về 0 khi reboot?**
  * Tất cả (trừ config) đều trắng bóc khi reboot (mất điện)
  > Chi tiết hơn: Là chỗ lưu /tmp/userdata/AdGuard/data nó không hỗ trợ nmap(2) vì format không hỗ trợ, cần bạn nào tìm hiểu phương pháp lưu các file database!
  > Vẫn có thể giữ số liệu bằng việc tạo crondtab liên tục sao lưu và bung ra sau khi reboot nhưng mà...sao lưu số liệu chi vậy?  
* **?: Tại sao phải set `Secondary DNS` là DNS bên thứ 3?**
  * Nếu chưa kịp cài lại và không set `Secondary DNS` thì router sẽ không có DNS để quay dịch domain, đồng nghĩa là bạn ***mất kết nối*** với internet. Vì thế nên để `Secondary DNS` thành bên DNS thứ 3 để tránh trường hợp quên chạy lại AdGuardHome thì vẫn có cái mà dùng  
* **?: Ở chỗ [Quay DNS](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/main/Integrations/AdGuard#2-quay-dns) tại `Secondary DNS` có thể gắn DNS khác không?**
  * Yep!
* **?: Không block ads trên điện thoại được với AdGuardHome?**
  * Vào `Cài Đặt -> Kết Nối -> Cài Đặt Kết Nối Khác`, chỉnh `DNS Riêng Tư` thành `Tắt`
  > Đấy là cách chỉnh dựa trên điện thoại Samsung, các điện thoại Android khác lẫn IPhone cũng sẽ có cách  
  > Cứ tra google là được mà
  * Còn nếu bạn đã để AdGuardHome cấp DHCP thì bạn không cần quan tâm phần trên, rất tiện khi khách tới nhà mà được sử dụng hệ thống chặn quảng cáo
* **?: Chỗ `Máy Chủ DNS` mà nó báo `Port 53 đã bị sử dụng`?**
  * Mở shell và nhập `killall dnsmasq` xong reload và tiếp tục
* **?: Có nên update khi AdGuard có bản update không?**
  * Bạn **KHÔNG CẦN** làm đâu, mà muốn thì cứ restart router là được
* **?: Mình có cần tắt DHCP server có sẵn của router không?**
  * Mình khuyên là có vì nếu AdGuardHome bị lỗi gì thì bạn còn vào router debug được, còn nếu đã tắt thì chỉ cần set static IP trên thiết bị rồi SSH vào sửa cũng được  
  * Nói chung là tuỳ, đối với AppleSang thì đang để tắt 
 ## 8: <ins>Điều bạn cần biết</ins>
 * 1: Tính năng AutoStartup có sẵn trong script đã chuyển qua sử dụng `tcapi`(Một trình quản lý romfile.cfg) để kích hoạt AdGuardHome mỗi khi router bật lên có một vấn đề là sau khi cài xong và reboot thì những setting sau đó liên quan tới router(Chỉnh wifi, set DDNS, *factory reset router*,...) đều hoạt động bất ổn định, có lúc nó thực thi, có lúc sẽ từ chối chạy. Cho nên việc chạy script install này là chắc chắn bạn đã hài lòng về cấu hình router hiện tại
   > Nếu bạn thắc mắc sao lại không sử dụng [autorun](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/autorun) thì mình muốn AdGuardHome hoạt động trên mọi router ở mọi điều kiện
   
   > Còn nếu bạn phản đối sử dụng tcapi thì tạo [Issue](https://github.com/Expl01tHunt3r/vnptmodemresearch/issues) và mình sẽ thay đổi
 * 2: Trong DNS Blocklist của AdGuardHome thì bạn **KHÔNG THỂ** chọn hết tất cả các Rule có sẵn vì 2 lý do:
   * Chọn hết thì bạn còn gì truy cập được internet nữa.
   * Chọn hết thì RAM sẽ không có đủ chỗ chứa và sẽ gây sập router->Khởi động lại cài AdGuardHome->Tải lại các rule đó->Sập->Và một dây chuyền vòng lặp sẽ diễn ra.
   > AppleSang đã bị như thế và cách fix là nhanh chóng khi Router chưa kịp cài AdGuardHome thì SSH xong ```rm /tmp/userdata/AdGuard/AdGuardHome.yaml``` và chờ router tự reboot lại
   * Đây là DNS Blocklist mình đang sử dụng, các bạn có thể tham khảo
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/9101b798-0810-4b54-a2cd-4fc56672d48d" />
   
   * **Mình khuyên bạn nên né cài ```HaGeZi's Threat Intelligence Feeds``` vì nó nặng gần 45MB nên bạn chỉ cài khi muốn stresstest router**

#

* **?: "Vấn đề khác của AdGuardHome mà trên kia không có!"**
  * Tạo [Issue](https://github.com/Expl01tHunt3r/vnptmodemresearch/issues) với title có đề `[AdGuard]` đầu để hỗ trợ
<h4 align="center">The End</h4>
<h6 align="right">AppleSang With 🍎</h6>
<h6 align="right">Edited by BussyBakks with my ass</h6>








