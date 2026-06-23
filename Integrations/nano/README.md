<div align="center">
<img width="128" height="128" alt="image" src="https://nano-editor.org/favicon.ico" />
</div>
<h4 align="center">nhưng là cho dòng 4 chữ~</h4>
<h6 align="left">AppleSang, D:23/M:06/Y:2026</h6>
<img width="27" height="27" alt="image" align="right" src="https://github.com/user-attachments/assets/de8413fe-b942-487b-a6d8-3f5111d292c9" />

## 1: <ins>Yêu cầu</ins>

* Mở được Telnet/SSH trên router đã đề cập ở [ngoài kia](https://github.com/Expl01tHunt3r/vnptmodemresearch?tab=readme-ov-file#3-shell-v%C3%A0-nh%E1%BB%AFng-ng%C6%B0%E1%BB%9Di-b%E1%BA%A1n-tty-ssh-)
* Đã cài patch [myshell](https://github.com/Expl01tHunt3r/vnptmodemresearch/blob/master/Integrations/myshell/README.md)

> [!WARNING]
> Hiện tại chỉ có dòng [GW040-NS](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-ns) đã confirm chạy okay  
> Còn dòng -H có lỗi reboot sau khi chạy script, chúng mình vẫn đang nấu vụ đó, mà ai có dòng -H có thể liên hệ [Discord](https://discordapp.com/users/1086149348414464041) để góp vui :)

## 2: <ins>Cài Đặt</ins>
### 2.1: Bước đầu cài đặt
* Paste đống lệnh này vào shell
```sh
cd /tmp && /userfs/bin/curl -s -k -o install-nano.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/master/Integrations/nano/install.sh && chmod +x install-nano.sh && sh install-nano.sh
```


* Ấn enter để xác nhận cài

* Và thế là xong. Chạy btop bằng cách nhập shell sau:
```sh
nano
```


## 6: <ins>FAQs</ins>
Cứ tạo issue với [nano] để giải đáp
<h4 align="center">The End</h4>
<h6 align="right">AppleSang With 🍎</h6>










### không cần quan tâm đâu

* export TERMINFO=/tmp/terminfo
* /tmp/SafeGate/nano
