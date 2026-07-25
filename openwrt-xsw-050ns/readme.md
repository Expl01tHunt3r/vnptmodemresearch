[![English](https://img.shields.io/badge/lang-English-blue.svg)](readme.md) [![Tiếng Việt](https://img.shields.io/badge/lang-Tiếng%20Việt-red.svg)](readme_vn.md)

## Specification

| Component  | Details |
|------------|---------|
| SoC        | Airoha AN7581CT, Quad-core ARM Cortex-A53 @ 1.2 GHz |
| RAM        | 512 MiB DDR4 2666 MHz (Winbond W664GG6RB) |
| Flash      | SPI-NAND 256 MiB (Winbond W25N02KV0) |
| WLAN       | MT7916AN + MT7976DN |
| Ethernet   | 1x 2500 Mbps WAN (Airoha EN8811H)<br>4x 10/100/1000 Mbps LAN1–LAN4 (Airoha AN7581 SoC switch) |
| XG-PON     | ECONET EN7572AN, SLIC: MaxLinear PEF32001VSV12 (XSW-250NS only) |
| USB        | None |
| Buttons    | Wi-Fi / Reset / WPS |
| LEDs       | 1x Power (green, GPIO-controlled)<br>1x WAN (green, GPIO-controlled)<br>4x LAN (green, GPIO-controlled) |
| Power      | 12 VDC, 1 A |

## Unsupported functions and limitations

1. XGS-PON will not be available after installing OpenWrt.
2. The NPU is enabled but Wi-Fi offload doesn't work at this time, only LAN <-> WAN.
   **(Enable Hardware Offloading in Firewall settings.)**
3. The MAC address is fixed to a default value, because the raw value in the stock firmware's factory partition is encrypted and cannot be read out.

## Installation / recovery (OpenWrt U-Boot layout)

1. Make sure you have a backup of the stock firmware before you start.
2. Place the OpenWrt images on the TFTP server (IP: `192.168.1.254`):
   - `openwrt-airoha-an7581-vnpt_xsw-050ns-bl31-uboot.fip`
   - `openwrt-airoha-an7581-vnpt_xsw-050ns-initramfs-recovery.itb`
   - `openwrt-airoha-an7581-vnpt_xsw-050ns-preloader.bin`
3. Attach a serial console and open **Tera Term** on Windows, connecting at **115200 baud**.
4. Hold down the Reset button (recessed in a hole on the case) and power on the router to enter recovery mode.
5. Press `x` in the terminal, then go to **File → Transfer → XMODEM → Send**.
6. Select the BL2 image file:
   `openwrt-airoha-an7581-vnpt_xsw-050ns-preloader.bin`
7. Wait until the file finishes transferring and the following prompt appears:
   `Press x to load BL31 + U-Boot FIP`
8. Press `x` in the terminal, then go to **File → Transfer → XMODEM → Send**.
9. Select the FIP image file:
   `openwrt-airoha-an7581-vnpt_xsw-050ns-bl31-uboot.fip`
10. Wait until the file finishes transferring; U-Boot will prepare the UBI partition automatically.
11. Wait for the U-Boot menu to appear.
12. Run **"Load BL31+U-Boot FIP via TFTP then write to NAND"**.
13. Run **"Load BL2 preloader via TFTP then write to NAND"**.
14. Run **"Boot system via TFTP"**.
15. Once booted into OpenWrt, perform a standard sysupgrade.
16. Turn off the device by pressing the power button, then turn it back on to restart.

## Changelog

- **First release** — based on OpenWrt commit [`aac6df7b`](https://github.com/openwrt/openwrt/commit/aac6df7b)

## Download
- [openwrt-airoha-an7581-vnpt_xsw-050ns-bl31-uboot.fip](openwrt-airoha-an7581-vnpt_xsw-050ns-bl31-uboot.fip)
- [openwrt-airoha-an7581-vnpt_xsw-050ns-initramfs-recovery.itb](openwrt-airoha-an7581-vnpt_xsw-050ns-initramfs-recovery.itb)
- [openwrt-airoha-an7581-vnpt_xsw-050ns-preloader.bin](openwrt-airoha-an7581-vnpt_xsw-050ns-preloader.bin)
- [openwrt-airoha-an7581-vnpt_xsw-050ns-squashfs-sysupgrade.itb](openwrt-airoha-an7581-vnpt_xsw-050ns-squashfs-sysupgrade.itb)