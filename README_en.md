<!-- hy-mt2-i18n:start -->
[Español](./README.md) | [中文](./README_zh-CN.md) | **English** | [日本語](./README_ja.md)
<!-- hy-mt2-i18n:end -->

<h1 align="center">VNPT Reverse Engineering & Rooting Project</h1>

***<h4 align="center">Nothing is impossible :)</h4>***

## 1: <ins>Goals</ins>
* Research on 4-digit network modem models from VNPT (currently focusing on -H, -NS, and -XS series)
* Crack the firmware and understand its encryption mechanisms (if time permits, try modifying it to OpenWRT as well)
* Have debrick files available in case the modem gets damaged (currently only available for -H and -NS series)
  
> [!CAUTION]
> **⚠️ Disclaimer ⚠️**<br>
> All content is intended solely for research and learning purposes.<br>
> Use in any illegal activities or network intrusions is not encouraged.<br>
> The user assumes full responsibility for their actions.<br>
> Following the steps outlined here (including installing applications) may result in loss of internet access or damage to your router.


#### Hope the developers at VNPT will pay attention to this.
---
## 2: <ins>Content</ins>
* [`flashdump/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/flashdump) NAND dump of the firmware for the GW-020H model (more models like -XS and -NS will be added soon)
* [`openwrt-initramfs-en751221/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/openwrt-initramfs-en751221) used for debricking if the firmware gets damaged due to improper modifications
* [`openwrt-xsw-050ns/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/openwrt-xsw-050ns) OpenWRT for the XSW050-NS model (thanks to [@longnt2007](https://github.com/longnt2007) for your contribution :3))
* [`tools/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/tools) tools for decrypting and encrypting romfile.cfg
* Tools for encrypting and decrypting files for the -XS (050) series will be added soon
* [`decrypted-cfgfile-xs/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/decrypted-cfgfile-xs) samples of romfile.cfg files for models that have been decrypted
* [`private-romfile-key/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/private-romfile-key) certificates and private keys for decrypting and encrypting.cfg files for the -XS model
* Firmware dumps that have had sensitive data stripped are available in [`squashfs-modified`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/squashfs-modified):
	* `boa-dump.bin`: the original firmware (GW020-H) during an upgrade via the web UI.
	* `squashfs.image`: the extracted squashfs portion (GW020-H), which can be decompressed using `unsquashfs`.
	* Firmware dumped from the GW040-H’s BOA
	* Decoded squashfs-root [here](https://github.com/ResearcherPT/vnptmodemresearch/releases)
 *  [`Integrations/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations) Guides and resources, along with commands for installing additional software, patches, etc...
---
## 3: <ins>Shell and its Friends (TTY, SSH,...)</ins>
* This section will guide you on how to access the router’s shell (console). Skip it if you already have access; otherwise, continue~~
> [!WARNING]  
> **⚠️ WARNING ⚠️**  
> Accessing the shell may inadvertently create vulnerabilities right within your network system!  
> Make sure only **YOU** are allowed to access it.  
> Do this by setting a difficult-to-guess password for your WiFi!  
> Use `passwd` to change your password as soon as you gain shell access (remember to update all accounts), otherwise it may be impossible to set up a whitelist for authorized access

### 3.1: UART
*If you can’t connect via UART, don’t worry—there are ways to access the shell without hardware cards for all models -H, -NS, and -XS.*
*Prepare a USB-UART adapter (CH340 or FT232BL chips are recommended for those on a tight budget) along with jumper wires.*
*Open the router’s casing [here](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/doc/disassemble) to expose the circuit board.*
*On the board near the LED, you’ll find three pins: `RX`, `TX`, and `GND`.*
*Connect them properly to avoid damaging the hardware (search Google for connection guides).*
*Make sure the connections are secure (you may need to solder them in place).*
### 3.2: Login Accounts
*When booting up and accessing via UART, you’ll see:*
  ```txt
  Please press Enter to activate this console.
  ```
*After connecting, it will display: `tc login:`*
*Credentials for -H and -NS:*
  * admin / VnT3ch@dm1n (full privileges like root, supports telnet, SSH, FTP)
  * operator / VnT3ch0per@tor (only available via UART)
  * customer / customer (limited privileges, supports telnet, SSH)
  * user3 / star (web interface, disabled by default, limited privileges, for -NS model)
*For the -XS model specifically:*
  * customer / customer (limited privileges, telnet only)
  * admin / $2$7c1ae60c120167530ca98a32c5323d9b89cff5bb (hashed password; exact password not yet found, supports telnet, console, FTP) (possible passwords: `1234`, `s2@We3%Dc#`, `admin4444`)
  * operator / $1$y....DM.$7eLwNxxQmjB1WmfB.ancV/ (hashed password; exact password not yet found, web interface) (password: `oper@tor`)
  * user3 / star (web interface, disabled by default, limited privileges)

* Once logged in successfully, you will directly enter the default shell (BusyBox Shell).
### 3.3: Telnet/SSH 
> [!TIP]
> I refer to the Web-UI as the management page for routers with IPs such as [192.168.1.1](https://192.168.1.1/) or [192.168.0.1](https://192.168.0.1/)  
> The Gateway is the IP of the router, for example 192.168.1.1 or 192.168.0.1  
> I will explain using the English interface.
* If you can access the Web-UI: Go to Web-UI -> Log in -> Navigate to the Access tab -> Go to the ACL Filter section -> Select Deactivated -> Then click Set.
* After disabling ACL, for:
  - Model -H: After performing the above steps, you will be able to access it right away :D (Confirmed by AppleSang; disabling it allows direct shell access).
  
  - Row -NS: On the Web-UI page itself, in the web access URL, delete the text ```content.asp``` and replace it with ```getGateWay.cgi```; accessing it will yield the result shown in the image below.
    <img width="542" height="135" alt="image" src="https://github.com/user-attachments/assets/5574f71b-d030-4c07-813a-8035c7554c8a" />
    
  - Row -HS: **No information available**
    
  - Row -XS: On the Web-UI page, delete ```content.asp````` from the web address and replace it with ```telnet.asp````. After accessing it, check ```TelnetSet: Enable````` and click ```Save````.
    <img width="1190" height="317" alt="image" src="https://github.com/user-attachments/assets/bceea390-af4c-4881-ac7a-ab641a913eca" />
    
* After completing the steps, open Command Prompt and enter
```
telnet your.ip.gateway
```
For example:
```bash
telnet 192.168.1.1
```
Or for lines -H and -NS, SSH can be used, for example:
```bash
ssh admin@192.168.1.1
```

> [!WARNING]  
> If the device doesn’t have Telnet enabled, open CMD **as an administrator** and run the following command:  
> ```bash  
> dism /online /Enable-Feature /FeatureName:TelnetClient

And return to [here](https://github.com/ResearcherPT/vnptmodemresearch/edit/master/README.md#32-t%C3%A0i-kho%E1%BA%A3n-login) to log in to the shell.

* If you can’t enable Telnet through the Web-UI, there’s a method that works on models with -NS and -XS options (you can also try it on other models):  
  - Prepare a small object like a toothpick that can fit into the router’s Reset button.  
  - After getting ready, press the WPS button **hard** with your finger. While pressing it, insert the toothpick into the Reset button and push it down firmly to activate it. When both buttons are pressed, check the lights on the router—there will be two possible outcomes:  
    - If the LOS light flashes: Release your fingers **immediately** and wait for the router to restart before trying again. **If you keep pressing too long, the router will erase all its configuration, forcing you to set it up from scratch.**  
    - If the PON light flashes: Hold both buttons down for about 6–7 seconds. Once the PON light starts flashing, Telnet has been enabled, and you can now connect!  
    - As an alternative for all models, log in to the web interface (192.168.1.1) and disable ACL to access Telnet/SSH.  
    - A quick note: XGS models only support Telnet, not SSH.




---
## 4: <ins>Patch romfile.cfg</ins>
* `romfile.cfg` is the config file obtained from:
```
(Gateway IP) → Maintenance → Backup/Restore
```
* The following information is stored in this file:
  + LOID, LOID password
  + SSID, Wi-Fi password
  + Network settings, firewall, cron,...
* **Note:** Since this file contains sensitive information (ISP username, router configuration details, etc.), do not share it with anyone outside this project unless you permit it. *You never know what they might do with your PPPoE account...*
* The decrypted `.cfg` file for the XS model can be found in the repo’s data.
### 4.1: Decrypt and modify
* `romfile.cfg` is encrypted using EVP_aes_256_cbc encryption by the binary `cfg_manager` (for -H models) and `/userfs/bin/cfg` (for -NS and -XS models).
* The keys/IVs for the -H and -NS models have been reversed. These two models use different keys/IVs, while the -XS model uses PKCS7 with a dumped private key (see the decryption/encryption code for details).
* It can be decrypted using tools in the repo. (**Note: Select the correct model to decrypt the right file. Using the wrong one will result in unreadable data. The XS model’s command is still under development; use a temporary command on your machine as a workaround!**)
* This method can also be used to add autostartup scripts without applying patches (though it only works for -H models because -NS has strict backup file checks and won’t accept modified backups. The -XS model also has a way to repackage the file after editing.)
	+ Specifically, for -XS models, after downloading `romfile.cfg` from the web UI, you can use the `openssl` command or a Python tool (used when retrieving configs from MTD dumps) to decrypt it.
```bash
openssl smime -decrypt -inform DER -in path/to/romfile.cfg -out /whatever/romfile.cfd.dec -inkey path/to/romfile_encrypt_privatekey.pem
```

   + The privatekey.pem file mentioned has been uploaded to the repo; make sure to point to the correct file.
   + After making the modifications (you can change the hashes of the accounts to set passwords as desired—this is how to obtain an admin shell on the current -XS model), the tool for generating hashes is available in this repo’s tools. Then you must encrypt the.cfg file using the following command:
```bash
openssl smime -encrypt -inform DER -outform DER \
  -in /path/to/modified/romfile.cfg \
  -out /whatever/path/tp/outfile/romfile.cfg \
  /path/to/romfile_encrypt_cert.pem
```
   + The cert.pem file here is the public key corresponding to the private key, which is already present in the modem and has been uploaded to this repo. You can find it in the same directory as the private key.
   + Done! You can now upload the backup file and enjoy!
   + A small note: if you change the hashes in the web password (those starting with $1$), the process will be slightly different. For example, if you want to reset the web password for the admin user with the password 123456, run the following command to get the hash:
```bash
openssl passwd -1 "uid = admin;psw = 123456"
```
and then replace the old hash with this new one. Do the same for other users. If changing the password for an operator, the uid will be operator, etc. If the password is 1234, the psw value will be 1234, etc.

* The usage instructions are already included in the tool; running the tool with empty arguments will display them.
### 4.2: Requirements to use the tool
* Python (tested from version 3.11.6 and compatible with versions 3.11.6 and above; actually, most recent versions work fine) with the pycryptodome package installed (`pip install pycryptodome`)
* *That’s all.*
### 4.3: Enabling Telnet/SSH by editing romfile.cfg (*Not lost after reboot but still lost after factory reset, applicable to models -H and -XS*)
* 1: Decrypt ``romfile.cfg``
* *Note: If? symbols (<img width="216" height="18" alt="image" src="https://github.com/user-attachments/assets/a164bc82-070f-4669-985d-dc05b7dc02a2" />) appear when reading the decrypted file, please review the steps. Prefer using local Python scripts (web-based tools are prone to errors). Once the file is corrupted during decryption, it can only be used for reading information, not for backups. A complete and error-free file is required to back up to the modem again (as double-content verification will be performed to confirm validity).*
* 2 (-H): Locate the Cron management section (labeled \<Crond\> in the file) and add
```bash
iptables -F INPUT; iptables -F FORWARD; iptables -F OUTPUT
```
Or (if semicolons are considered invalid)
```bash
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
```
People can add additional commands if desired beyond these.

* *Note1: For -XS specifically, you can enable telnet by setting the Active value of the accounts to Yes. It’s usually already enabled; you just need to disable ACL or click the button as instructed. If not, log in to the admin web interface and navigate to the URL `telnet.cgi` or `telnet.asp` to turn it on.*

* Continue... if you are working on the -H model

* It will look like this (here, `/1 * * * *` means the command will run every minute)
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
* Then encrypt it again and upload it to the gateway’s webUI.


* (For the -NS model) Please search [OpenWRT](https://openwrt.org/) for one of the following routers:  
    *  [Netis NX31](https://openwrt.org/toh/netis/nx31)  
    *  [Xiaomi AX3000T](https://openwrt.org/inbox/toh/xiaomi/ax3000t)  
    *  [JCG Q30 PRO](https://openwrt.org/toh/jcg/q30_pro)  
* Follow the instructions to flash OpenWRT, after which you can choose whether to flash back to the original firmware or keep it for use as desired.  
* You can use the following types of ROMs: OpenWRT, ImmortalWRT, Keenetic, Gecoos, Netis,... (In general, any ROM that works on Viettel’s model aAP 32x6v1 will work on this device, and all instructions can be followed using that model as reference).

* Reference:

  * Below is the link to an OpenWRT firmware version currently under development for the VR1200v modem. Since it shares the same SoC as the -H series, it should work, but it lacks WiFi and LAN drivers...
  * A compatible OpenWRT version will be modified in the future; for now, it’s only intended for debricking.
  * Please read and follow the instructions at the [Debricking](https://openwrt.org/inbox/toh/tp-link/archer_vr1200v#debricking) section of the OpenWRT guide for the TP-Link Archer VR1200v router.

 * Thank you to [@cjdelisle](https://github.com/cjdelisle) for the [initramfs](https://github.com/ResearcherPT/vnptmodemresearch/blob/master/openwrt-initramfs-en751221/openwrt-econet-en751221-en751221_generic-initramfs-kernel.bin)!  
* It’s not yet confirmed exactly, but it’s possible that the XS model uses firmware from a Chinese manufacturer: Baidu (?)  
---  
## 6: <ins>Decode firmware from `/tmp/boa-temp`</ins>  
<details>  
<summary>Run commands in the modem’s shell (click to expand)</summary>
	
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

            # If it doesn’t change for 2 consecutive times (2 seconds) => upload is complete
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

> [!NOTE]  
> On the -NS board, there is no YAFFS volume mounted, so when running that script on such a board, the dumped file will still be lost after the firmware upgrade.  
> It is recommended to change the output path from `/tmp/yaffs/*` to `/tmp/userdata/*` if running it on -NS or -XS boards.

# Strict Constraints
1. **Structure Lock**: Absolutely maintain the original Markdown data structure, indentation, heading levels, tables, links, URLs, badges, code blocks, and inline codes unchanged.
2. **Selective Translation**: Only translate visible natural language content intended for users.
3. **Prohibition of Modifications**: It is strictly forbidden to translate or alter code tags, key names, variable placeholders (such as {{var}}, ${var}, %s, %d, etc.), command examples, file paths, project names, API names, package names, model names, identifiers, and code symbols; unless a corresponding translation is provided in the background information.
4. The translations of terms, styles, and proper nouns should be consistent with those given in the background information.

【待翻译片段】
* Run the script `/tmp/auto_dump_boatemp.sh`
* Upgrade the firmware as usual
* After rebooting, return to the shell, retrieve the file `/tmp/userdata/boa-dump.bin` (`/tmp/yaffs/boa-dump.bin` if using the -H option), then you can use `binwalk` or `unsquashfs` to analyze it
* **Notes**
	* You can modify the `boa-temp` file during the upgrade to force flash a custom firmware, but there is a high risk of bricking if the timing is incorrect, the exact offset is unknown, or important files are overwritten.
	* You can manually trigger an upgrade by editing the nvram fw_upgrade name through tcapi (commit after setting), but you must first pass the check to confirm the firmware is valid (currently not possible).
---
## 7: <ins>.asp</ins>
* On VNPT models (the exact firmware version is unknown), the.asp files in cgi-bin will be encrypted. To facilitate firmware modification or to read the logic flow, these files need to be decoded. During research, it was found that the files are only simply encrypted via bit reversal, so they can be decoded by reversing the bits again.
* The Python code for decoding ASP files is available in `tools/asp-decoder.py`. Running this code will provide instructions.
* When modifying ASP files, to ensure compatibility with the operating process, they must be re-encrypted and flashed in place of the original files.
---
## 8: <ins>Applications</ins>
* [AdGuardHome](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/AdGuard)
* [ddns-updater](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/ddns_updater)
* Caddy (In progress)
* [Btop](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/btop)
* [nano](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/nano)
> Installation guides are available in the README for each application
---
## 9: Patch (For NS Models)
* [autorun](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/autorun)
* [myshell](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/myshell) 
---
## 10: <ins>Discussion</ins>
* [VOZ](http://voz.vn/t/vnptmodemresearch-%E2%80%94-nghien-cuu-firmware-root-modem-vnpt-can-anh-em-chung-tay.1159218)
* [Github](https://github.com/ResearcherPT/vnptmodemresearch/discussions/10)
* ~~Discord~~
---
## 11: <ins>Upcoming Goals (For 040-NS)</ins>
* Install OpenWRT (Already works on -NS -> Testing additional PON drivers -> ~~Planned for next year~~)
  * Install some type of VPN
* Customize the functions of the WPS/WLAN button to add other features (Such as obtaining a new IP within 5 seconds,...)
* Easily control LEDs to display different information (Such as CPU usage level, warnings when RAM is nearly exhausted,...)
* Customize the firmware to facilitate further development (Such as customizing the Web-UI, adding or removing features, optimizing performance)
  * Already released here [here](https://github.com/ResearcherPT/gw040ns-firmware)
## Updates
* I created an online web tool that allows users to decode and encode files on their own without needing others to install anything here: [https://huggingface.co/spaces/Expl01tHunt3r/file-decoder]  
	* (or use a Vietnamese hosting service with a ping time of only 15ms!! → https://cfgdecoder.fkrystal.qzz.io)  
    > AppleSang: Trust me, you’ll like downloading this tool to encode files by yourself  
* Since it’s free, there might be occasional glitches—please bear with patience. You can check the status here: [https://stats.uptimerobot.com/U65yw18Rtl]  
* Keys/IVs for the NS series are now available, and the code has been improved to add more options for this series.  
* It has been confirmed that the romfile editing tool works with models [GW020-H](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw020-h), [GW240-H](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw240-h), [GW040-H](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-h), [GW040-NS](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-ns), and commands also work with model [GW050-XGS](https://www.vnpt-technology.vn/vi/product_detail/xgs-pon-ont-igate-xsw050-ns).  
* A way to decode.asp files in the cgi-bin folder has been found.  
* The cfg files on these models have the following structure: gzip compression → HD3R header, version, length, etc. (256 bytes) → data encrypted using PKCS7 structure

## Contributions:
- Thank you to [@BussyBakks](https://github.com/BussyBakks) and [@AppleSang](https://github.com/AppleSang) for helping me further research the keys for the romfile.cfg of NS modem models and install various applications.
- Thanks to [@longnt2007](https://github.com/longnt2007) for porting OpenWRT to the XSW050-NS model.


<p align="center">Created with ❤️ by Expl01tHunt3r</p>
