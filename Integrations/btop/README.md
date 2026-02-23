<div align="center">
<img width="349" height="98" alt="image" src="https://github.com/user-attachments/assets/678652c5-d011-4e3b-9bb7-037ffa8b979a" />
</div>
<h4 align="center">nhưng là cho dòng 4 chữ~</h4>
<h6 align="left">AppleSang, D:02/M:01/Y:2026</h6>
<h6 align="left">BussyBakks, D:09/M:01/Y:2026</h6>
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
cd /tmp && /userfs/bin/curl -k -o install-btop.sh https://raw.githubusercontent.com/Expl01tHunt3r/vnptmodemresearch/refs/heads/master/Integrations/btop/install.sh && chmod +x install-btop.sh && sh install-btop.sh
```
* Chờ cho đến khi dòng này được print ra  
<img width="585" height="50" alt="image" src="https://github.com/user-attachments/assets/166ca458-fdc5-4cce-a271-878a292a2d4c" />

* Và thế là xong. Chạy btop bằng cách nhập shell sau:
```sh
/tmp/userdata/btop/btop --force-utf
```

## 6: <ins>FAQs</ins>
**ờ thì có gì để nói đâu?**
<h4 align="center">The End</h4>
<h6 align="right">AppleSang With 🍎</h6>









