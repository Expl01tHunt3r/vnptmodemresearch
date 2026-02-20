<h1 align="center">myshell</h1>
<h4 align="center">Tôi muốn shell nó tốt hơn mặc định</h4>
<h6 align="left">AppleSang, D:20/M:02/Y:2026</h6>

## 1: <ins>Yêu cầu</ins>
<img width="128" height="128" alt="image" src="https://github.com/user-attachments/assets/c4ea7500-9d32-441b-9458-973d59e0d369" align="right" />

* Mở được Telnet/SSH trên router đã đề cập ở [ngoài kia](https://github.com/Expl01tHunt3r/vnptmodemresearch?tab=readme-ov-file#3-shell-v%C3%A0-nh%E1%BB%AFng-ng%C6%B0%E1%BB%9Di-b%E1%BA%A1n-tty-ssh-)
* Đã chạy patch [autorun](https://github.com/Expl01tHunt3r/vnptmodemresearch/tree/master/Integrations/autorun)
> [!CAUTION]
> **Bạn sẽ tự chịu hết các hậu quả đi kèm nếu làm theo!!!**  
> **Và chúng mình KHÔNG CHỊU TRÁCH NHIỆM nếu bị lỗi trên router nhà bạn**  
> *đã nhắc rồi nhé.*

> [!WARNING]
> Hiện tại chỉ có dòng [GW040-NS](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-ns) đã confirm chạy okay  
> Còn dòng -H thì đang không có để test .-. 
> Nếu bạn có thì vui lòng liên hệ [Discord](https://discordapp.com/users/1086149348414464041) để góp vui :)

## 2: <ins>Cài Đặt</ins>
* SSH/Telnet vào router  
<img width="469" height="146" alt="image" src="https://github.com/user-attachments/assets/cde8d9f6-be70-44d9-86bd-41d13cd54da5" />

* Paste lệnh dưới vào shell
```sh
cd /tmp/SafeGate/ && /userfs/bin/curl -s -k -o autorun.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/master/Integrations/autorun/patch.sh && chmod +x autorun.sh && sh autorun.sh
```
