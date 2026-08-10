<!-- hy-mt2-i18n:start -->
[Español](./README.md) | **中文** | [English](./README_en.md) | [日本語](./README_ja.md)
<!-- hy-mt2-i18n:end -->

<h1 align="center">VNPT逆向工程与越狱项目</h1>

<h4 align="center">没有不可能的事 :)</h4>

## 1: <ins>目标</ins>
* 研究越南电信的4位数字系列调制解调器（目前正在研究-H、-NS、-XS系列）
* 解析固件，了解固件中的加密机制（如果有时间且精力允许的话，尝试将其改造成OpenWRT版本）
* 若因操作导致调制解调器损坏，能拥有用于恢复功能的文件（目前仅能用于恢复-H、-NS系列）
  
> [!CAUTION]
> **⚠️ 免责声明 ⚠️**<br>
> 所有内容仅用于研究及学习目的。<br>
> 不建议将其用于任何违法或入侵网络系统的行为。<br>
> 用户需自行承担所有责任。<br>
> 按照此处所述步骤操作（包括安装应用）可能会导致您失去网络连接或损坏路由器。


#### 希望VNPT的开发者们能够予以关注。

### 3.1: UART
*如果您无法通过UART连接也无需担心，其实还有无需硬件转接卡就能进入-H、-NS、-XS系列路由器shell的方法*
*准备一个USB-UART转换器（建议预算有限的用户使用CH340或FT232BL芯片）以及跳线。*
*打开路由器外壳[查看电路板](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/doc/disassemble)*
*在靠近LED灯的电路板上会有3个引脚：`RX`、`TX`、`GND`。*
*请正确连接以避免损坏硬件（可自行在谷歌上搜索相关连接指南）。*
*注意确保线路连接牢固（必要时可进行焊接处理）。*
### 3.2: 登录账户
*当路由器启动并通过UART接入时，会看到如下提示：*
  ```txt
  Please press Enter to activate this console.
  ```
*成功连接后则会显示：`tc login:`*
*-H、-NS系列的登录凭证为：*
  * admin / VnT3ch@dm1n（拥有完整权限，支持telnet、SSH、FTP功能，相当于root权限）*
  * operator / VnT3ch0per@tor（仅支持UART连接）*
  * customer / customer（权限较低，支持telnet、SSH功能）*
  * user3 / star（可通过网页登录，默认已禁用，权限较低，适用于-NS系列）*
*针对-XS系列则有所不同：*
  * customer / customer（权限较低，仅支持telnet连接）*
  * admin / $2$7c1ae60c120167530ca98a32c5323d9b89cff5bb（密码为哈希值，目前尚未找到真实密码，支持telnet、控制台访问及FTP功能）（尝试过密码`1234`、`s2@We3%Dc#`、`admin4444`）*
  * operator / $1$y....DM.$7eLwNxxQmjB1WmfB.ancV/（密码为哈希值，目前尚未找到真实密码，仅支持网页登录）（尝试过密码`oper@tor`）*
  * user3 / star（可通过网页登录，默认已禁用，权限较低）*

* 成功登录后将直接进入默认的shell环境（BusyBox Shell）
### 3.3: Telnet/SSH 
> [!TIP]
> 我将IP为[192.168.1.1](https://192.168.1.1/)或[192.168.0.1](https://192.168.0.1/)的路由器管理页面称为Web-UI  
> Gateway则是路由器的IP地址，例如192.168.1.1或192.168.0.1  
> 接下来我将以英文界面进行说明
* 如果您能够访问Web-UI：进入Web-UI -> 登录 -> 转到Access选项卡 -> 进入ACL Filter部分 -> 选择Deactivated -> 然后点击Set
* 关闭ACL后对于：
  - -H型号：完成上述操作后即可直接进入shell了 :D（经AppleSang确认，关闭该功能后可直接使用shell）
  
  - Dòng -NS：在Web-UI页面中，将网页访问地址里的```content.asp```删除并替换为```getGateWay.cgi```，访问后就会得到如下图片所示的结果
    <img width="542" height="135" alt="image" src="https://github.com/user-attachments/assets/5574f71b-d030-4c07-813a-8035c7554c8a" />
    
  - Dòng -HS：**暂无相关信息**
    
  - Dòng -XS：在Web-UI页面中，将网页访问地址里的```content.asp```删除并替换为```telnet.asp```，访问后勾选```TelnetSet: Enable```，然后点击```Save```。
    <img width="1190" height="317" alt="image" src="https://github.com/user-attachments/assets/bceea390-af4c-4881-ac7a-ab641a913eca" />
    
* 完成设置后，打开命令提示符并输入
```
telnet 您的网关IP地址
```
例如：
```bash
telnet 192.168.1.1
```
而对于 -H、-NS 类型，则可以直接使用 SSH，例如：
```bash
ssh admin@192.168.1.1
```

> [!警告]
> 如果设备尚未安装Telnet功能，请以**管理员权限**启动CMD，然后运行以下命令
> ```bash
> dism /online /Enable-Feature /FeatureName:TelnetClient

然后返回[此处](https://github.com/ResearcherPT/vnptmodemresearch/edit/master/README.md#32-t%C3%A0i-kho%E1%BA%A3n-login)以登录shell。

* 如果您无法通过Web界面启用Telnet，那么在 -NS、-XS型号上有一种可行的方法（您也可以尝试在其他型号上使用）：
  - 准备一根足够细的小棒，只要能插入路由器的Reset按钮即可
  - 准备好之后，用手指**用力按压**WPS按钮，就在按住的同时用小棒刺入Reset按钮并用力按住，使两个按钮同时被按下。当两个按钮都处于按下状态时，观察路由器上的指示灯，会出现两种情况：
    - LOS指示灯闪烁：请**立即**松开手，等待路由器重启后再重试。**如果仍故意长时间按住，路由器将会清除所有配置，迫使您从头开始设置**
    - PON指示灯闪烁：您需要持续按压这两个按钮约6-7秒，当PON指示灯开始闪烁时，就表示Telnet已成功启用，现在就可以进行连接了！
    - 若上述方法都不行，对于所有型号还有一个办法，即登录管理网页（192.168.1.1）然后关闭ACL，这样就能访问Telnet/SSH了
    - 需要注意的是，XGS型号只有Telnet功能，没有SSH功能




---
## 4: <ins>修改romfile.cfg文件</ins>
* `romfile.cfg`是从以下路径获取的配置文件：
```
(Gateway IP) → Maintenance → Backup/Restore
```
* 该文件中存储有以下信息：
  + LOID及LOID密码
  + SSID及Wi-Fi密码
  + 网络配置、防火墙设置、cron任务等
* **注意：** 此文件包含大量敏感信息（如ISP用户名、路由器配置信息等），若允许的话请勿与项目之外的任何人共享。*你根本不知道他们会对你的PPPoE账户做些什么……*
* XS型号解密后的.cfg文件可在本仓库的data目录中找到
### 4.1: 解密与修改
* `romfile.cfg`是由`cfg_manager`二进制文件（-H型号）以及 `/userfs/bin/cfg`文件（-NS、-XS型号）使用EVP_aes_256_cbc加密算法加密的
* -H型号和-NS型号的密钥/随机数向量已被逆向解析，这两个型号使用不同的密钥/随机数向量，而-XS型号则采用PKCS7格式并使用已导出的私钥进行加密（具体细节可查看用于解密/加密romfile的代码）
* 可以使用本仓库中的工具进行解密（**注意：需选择正确的型号才能解密对应的文件，否则无法读取。XS型号的对应代码仍在编写中，可暂时在本地机器上使用相应命令替代！**）
* 这种方法还可用于添加自动启动脚本而无需安装补丁（不过仅对-H型号有效，因为-NS型号对备份文件的检查机制较为严格，不会接受修改后的备份文件，而-XS型号也有修改后的重新打包方法）
	+ 具体而言，对于-XS型号，在从webui下载romfile.cfg后，可使用命令（需安装openssl）或Python工具（适用于从mtd转储文件中获取配置的情况）来进行解密
```bash
openssl smime -decrypt -inform DER -in path/to/romfile.cfg -out /whatever/romfile.cfd.dec -inkey path/to/romfile_encrypt_privatekey.pem
```

   + 上述的 privatekey.pem 文件已上传至仓库中，请确保指向正确的文件  
   + 修改完成后（你可以更改各账户的哈希值以自定义密码，这正是当前 -XS 模型获取管理员Shell的方法），该仓库的 tools 中已有用于生成哈希值的工具），随后你需要使用以下命令对.cfg 文件进行重新加密：  
```bash
openssl smime -encrypt -inform DER -outform DER \
  -in /path/to/modified/romfile.cfg \
  -out /whatever/path/tp/outfile/romfile.cfg \
  /path/to/romfile_encrypt_cert.pem
```
   + 上述的 cert.pem 文件是与 private key 相对应的公钥，它存在于模块中，现已上传至该仓库，你可以在与 private key 同一的目录中找到它  
   + 完成！现在你可以上传备份文件并尽情使用了！  
   + 小提示：如果你要更改网页密码中的哈希值（以 $1$ 开头），操作方式会有所不同。例如，若想为名为 admin 的用户设置密码为 123456，需先运行以下命令获取哈希值：  
```bash
openssl passwd -1 "uid = admin;psw = 123456"
```
然后再用这个新哈希值替换旧的哈希值，其他用户也需按相同步骤操作；如果为操作员更改密码，则 uid 为 operator，……若密码为 1234，则 psw 处填写 1234，……

* 工具中已包含使用指南，空参数运行该工具即可显示说明
### 4.2: 使用工具的要求
* Python（已测试过3.11.6版本，3.11.6及以上版本均可运行，实际上大多数新版本都能使用），并且需安装pycryptodome包 `pip install pycryptodome`
* *就这些*
### 4.3: 通过编辑romfile.cfg开启Telnet/SSH（*重启后不会丢失，但恢复出厂设置后会丢失，适用于-H、-XS型号*）
* 1: 解密“romfile.cfg”
* *注意：如果读取解密后的文件出现？号（<img width="216" height="18" alt="image" src="https://github.com/user-attachments/assets/a164bc82-070f-4669-985d-dc05b7dc02a2" />），请检查操作步骤，优先使用本地运行的Python代码（网页上的工具容易出错）。一旦解密文件出错，则无法用于备份，只能用来读取信息。只有文件完整且无错误，才能重新备份到调制解调器中（因为会进行双重内容校验以确认有效性）*
* 2 (-H型号)：找到Cron管理位置（文件中为\<Crond\>），然后添加
```bash
iptables -F INPUT; iptables -F FORWARD; iptables -F OUTPUT
```
或者（如果分号被视为无效时）
```bash
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
```
除此命令外，大家可根据需要添加其他命令。

* *注1：对于 -XS 模型，您可以通过将相关账户的 Active 值改为 Yes 来启用 telnet 功能，通常这些账户已是激活状态，您只需关闭 ACL 或按说明操作即可；如果不希望这样，也可以登录管理网页，访问 `telnet.cgi` 或 `telnet.asp` 这些地址并将其设置为启用状态。

* 接下来……如果您正在使用 -H 模型操作

* 它看起来会像这样（这里的 `/1 * * * *` 表示该命令每分钟执行一次）
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
* 接着再次加密后上传到网关的webUI即可
---
## 5: <ins>使用OpenWRT initramfs进行解砖</ins>
* （针对 -H型号）当调制解调器出现故障时：
	* 尝试重启（使用busybox reboot），如果还有shell则重启路由器。
 	* 尝试通过路由器的电源按钮关闭后再重新开启
	* 如果仍然无法进入shell：
 		* 打开调制解调器的电源
    	* 使用OpenWrt initramfs通过UART临时启动。
    	* 从备份中重新刷入mtdX.bin文件。
    	* 重新启动并恢复配置（`romfile.cfg`），或者为了更加稳妥，可以再次通过webUI下载固件并更新。


* （针对 -NS 型号）请在 [OpenWRT](https://openwrt.org/) 上搜索以下路由器之一：
    *  [Netis NX31](https://openwrt.org/toh/netis/nx31)
    *  [Xiaomi AX3000T](https://openwrt.org/inbox/toh/xiaomi/ax3000t)
    *  [JCG Q30 PRO](https://openwrt.org/toh/jcg/q30_pro)
* 按照说明操作即可刷入 OpenWRT，之后是想刷回原厂系统还是继续保留使用则由您决定
* 您可以使用以下类型的固件：OpenWRT、ImmortalWRT、Keenetic、Gecoos、Netis 等……（一般来说，Viettel 的 aAP 32x6v1 型号能运行的固件这款也能运行，所有说明均可参照上述型号进行操作）

* 参考：

  * 以下是为VR1200v调制解调器正在开发的OpenWRT固件版本链接，该设备与-H系列采用相同的SoC，因此可以使用，但目前尚无WiFi、LAN等驱动程序。
  * 日后将会开发出兼容的OpenWRT版本，目前此版本仅用于破砖恢复。
  * 请阅读并遵循OpenWRT发布的TP-Link Archer VR1200v路由器[破砖恢复](https://openwrt.org/inbox/toh/tp-link/archer_vr1200v#debricking)指南中的操作步骤。

 * 感谢[@cjdelisle](https://github.com/cjdelisle)提供了[initramfs](https://github.com/ResearcherPT/vnptmodemresearch/blob/master/openwrt-initramfs-en751221/openwrt-econet-en751221-en751221_generic-initramfs-kernel.bin)！
* 目前尚未确定，但XS型号的固件底层很可能是来自中国的一家厂商：百度(？)
---
## 6: <ins>从/tmp/boa-temp解码固件</ins>
<details>
<summary>在路由器的shell中运行命令（点击展开）</summary>
	
<details>
<summary>在调制解调器的shell中运行命令（点击展开）</summary>
```shell
sed -i '1,$d' /tmp/auto_dump_boatemp.sh
cat >> /tmp/auto_dump_boatemp.sh <<'EOF'
#!/bin/sh
out="/tmp/yaffs/boa-dump.bin"
mkdir -p /tmp/yaffs

echo "[*] 正在等待 /tmp/boa-temp 完成上传..."
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

            # 如果连续两次（2秒内）大小没有变化，则表示上传已完成
            if [ "$stable_count" -ge 2 ]; then
                cp /tmp/boa-temp "$out"
                echo "[+] 已将 boa-temp（$size 字节）转存到 $out”
                break
            fi
        fi
    fi
    sleep 1
done
EOF

chmod +x /tmp/auto_dump_boatemp.sh
```

> [!NOTE]  
> 在 -NS 模式下不会对 yaffs 格式的分区进行挂载，因此在该模式下运行脚本时，升级完成后已转储的文件仍会丢失。  
> 建议如果在 -NS、-XS 模式下运行，将输出路径从 `/tmp/yaffs/*` 更改为 `/tmp/userdata/*`。

# 严格约束
1. **结构锁定**：绝对保持原有的 Markdown 数据结构、缩进、标题层级、表格、链接、URL、徽章、代码块和行内代码完全不变。
2. **选择性翻译**：仅翻译面向用户展示的可见自然语言内容。
3. **禁止修改**：**严禁**翻译或更改代码标签、键名、变量占位符（如 {{var}}、${var}、%s、%d 等）、命令示例、文件路径、项目名、API 名、包名、模型名、标识符和代码符号；除非背景信息中已经给出对应译名。
4. 术语、风格、专有名词的译法要与所给背景信息保持一致。

【待翻译片段】
* 运行脚本 `/tmp/auto_dump_boatemp.sh`
* 按常规方式升级固件
* 重启完成后回到shell，获取文件 `/tmp/userdata/boa-dump.bin`（若使用 -H 参数则为 `/tmp/yaffs/boa-dump.bin`），随后可使用 `binwalk` 或 `unsquashfs` 进行分析
* **注意事项**
	* 在升级过程中可以修改 `boa-temp` 文件以强制写入自定义固件，但如果时机不当、不清楚准确偏移量或覆盖了重要文件，设备极有可能变砖。
	* 也可以通过修改tcapi中的fw_upgrade名称来手动触发升级（设置后需提交代码），但必须先通过固件有效性检查（目前暂不可行）。
---
## 7: <ins>.asp</ins>
* 在VNPT版本的设备上（尚不确定具体是哪个固件版本），cgi-bin目录下的.asp文件会被加密，为了方便修改固件或读取逻辑流程，需要先解码这些文件。研究中发现这些文件只是通过简单的位翻转进行加密，因此再次执行位翻转操作即可解码。
* 用于解码asp文件的Python代码位于 `tools/asp-decoder.py` 中，运行该代码会附带操作指南。
* 修改ASP文件后，为使其能正常工作，需要将其重新编码并刷写到原有文件的位置。
---
## 8: <ins>应用软件</ins>
* [AdGuardHome](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/AdGuard)
* [ddns-updater](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/ddns_updater)
* Caddy（正在开发中）
* [Btop](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/btop)
* [nano](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/nano)
> 各应用软件的安装指南已在对应的README文件中提供
---
## 9: 补丁（针对NS系列设备）
* [autorun](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/autorun)
* [myshell](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/myshell) 
---
## 10: <ins>讨论区</ins>
* [VOZ](http://voz.vn/t/vnptmodemresearch-%E2%80%94-nghien-cuu-firmware-root-modem-vnpt-can-anh-em-chung-tay.1159218)
* [Github](https://github.com/ResearcherPT/vnptmodemresearch/discussions/10)
* ~~Discord~~
---
## 11: <ins>未来计划（针对040-NS型号）</ins>
* 安装OpenWRT（已在-NS型号上运行成功 -> 正在测试更多PON驱动 -> ~~计划明年发布~~）
  * 安装某种VPN功能
* 对WPS/WLAN按钮的功能进行定制，赋予其新特性（例如5秒内自动获取新IP等）
* 能够轻松控制LED灯来显示其他信息（如CPU使用率、内存即将耗尽的警告等）
* 定制固件以便进一步开发（如自定义Web界面、增减功能、优化性能）
  * 相关固件已在此[地址](https://github.com/ResearcherPT/gw040ns-firmware)发布
## 更新内容
* 我制作了一个在线网页，无需大家额外安装任何软件即可自行解码和加密文件，地址为[这里](https://huggingface.co/spaces/Expl01tHunt3r/file-decoder)
	* （或者使用延迟仅为15毫秒的越南服务器！！→ https://cfgdecoder.fkrystal.qzz.io）
    > AppleSang：相信我，你一定会喜欢下载这个工具来自己进行加密的
* 由于是免费服务，有时可能会出现不稳定情况，还请大家耐心等待，状态可查看[这里](https://stats.uptimerobot.com/U65yw18Rtl)
* 目前已为NS系列提供密钥/初始化向量，同时优化了代码以便为NS系列添加更多选项
* 已确认该romfile编辑工具能够用于[GW020-H](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw020-h)、[GW240-H](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw240-h)、[GW040-H](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-h)、[GW040-NS](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-ns)这些型号，且相关命令也能在[GW050-XGS](https://www.vnpt-technology.vn/vi/product_detail/xgs-pon-ont-igate-xsw050-ns)型号上运行
* 已找到解码cgi-bin目录下.asp文件的方法
* 各型号的cfg文件结构如下：先经过gzip压缩→HD3R头部信息、版本号、长度等（256字节）→通过PKCS7结构加密的数据

## 贡献：
- 感谢[@BussyBakks](https://github.com/BussyBakks)和[@AppleSang](https://github.com/AppleSang)两位朋友帮助我进一步研究NS系列调制解调器的romfile.cfg密钥并安装相关应用。
- 感谢[@longnt2007](https://github.com/longnt2007)将OpenWRT移植到XSW050-NS上。


<p align="center">由 Expl01tHunt3r 用心制作 ❤️</p>
