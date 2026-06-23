<h1 align="center">Autorun</h1>
<h4 align="center">Chớ gì phải tự chạy lại thủ công mỗi lần cúp điện, nhể?</h4>
<h6 align="left">AppleSang, D:11/M:01/Y:2026</h6>
<h6 align="left">BussyBakks, D:11/M:01/Y:2026</h6>
<h6 align="left">Expl01tHunt3r, D:13/M:01/Y:2026</h6>

## 1: <ins>Yêu cầu</ins>
<img width="128" height="128" alt="image" src="https://github.com/user-attachments/assets/b17f8ebf-e35e-4d68-9d60-a06b93767dc8" align="right" />

* Mở được Telnet/SSH trên router đã đề cập ở [ngoài kia](https://github.com/Expl01tHunt3r/vnptmodemresearch?tab=readme-ov-file#3-shell-v%C3%A0-nh%E1%BB%AFng-ng%C6%B0%E1%BB%9Di-b%E1%BA%A1n-tty-ssh-)
* Phải đang ở bản build của ngày 5/3/2025 (đây là bản được confirm) hoặc là các bản build có kèm theo tính năng Familysafe trên lý thuyết đều có thể chạy | Có thể check trong WebUI
> Không nhất thiết nhưng nếu bản firmware của bạn chưa phù hợp thì có thể tải tại [đây](https://blogvnpt.blogspot.com/2025/03/firmware-g040e5vn0t0203-cho-gpon-ont_18.html)

> [!CAUTION]
> **Bạn sẽ tự chịu hết các hậu quả đi kèm nếu làm theo!!!**  
> **Và chúng mình KHÔNG CHỊU TRÁCH NHIỆM nếu bị lỗi trên router nhà bạn**  
> *đã nhắc rồi nhé.*

> [!WARNING]
> Hiện tại chỉ có dòng [GW040-NS](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-ns) đã confirm chạy okay  
> Còn dòng -H thì đang không có để test .-. Mà cũng không khuyến khích chạy script -NS lên dòng -H do nhiều khác biệt trong firmware 
> Nếu bạn có thì vui lòng liên hệ [Discord](https://discordapp.com/users/1086149348414464041) để góp vui :)

## 2: <ins>Cài Đặt</ins>
* SSH/Telnet vào router  
<img width="469" height="146" alt="image" src="https://github.com/user-attachments/assets/cde8d9f6-be70-44d9-86bd-41d13cd54da5" />

* Paste lệnh dưới vào shell
```sh
cd /tmp/ && /userfs/bin/curl -s -k -o autorun.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/master/Integrations/autorun/patch.sh && chmod +x autorun.sh && sh autorun.sh
```

* Bấm **Enter** 
* **Enter** thêm lần nữa.  
<img width="979" height="521" alt="image" src="https://github.com/user-attachments/assets/466daa99-95ac-4dbd-b336-dd833eee03ac" />

* chờ....
* chờ....
* xong rồi đó, giờ router sẽ chạy những lệnh trong file `/tmp/userdata/startup.sh` khi vừa khởi động lên
* nếu bạn muốn edit thì chỉ có thể xài `echo` hoặc `sed`
* còn cách sử dụng autorun thì nó sẽ tự chạy mỗi lần router mất điện, thế thôi hỏi làm chi?
* Tuy nhiên bạn nên nhớ khi thêm script trong startup.sh *tuyệt đối* không được để rò output ra, nếu không sẽ fail và phải cài lại từ đầu

## script này có thể được coi debloat familysafe của vnpt
