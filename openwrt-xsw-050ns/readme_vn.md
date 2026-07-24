[![English](https://img.shields.io/badge/lang-English-blue.svg)](README.md) [![Tiếng Việt](https://img.shields.io/badge/lang-Tiếng%20Việt-red.svg)](README_VN.md)

## Thông số kỹ thuật

| Thành phần | Chi tiết |
|------------|----------|
| SoC        | Airoha AN7581CT, 4 nhân ARM Cortex-A53 @ 1.2 GHz |
| RAM        | 512 MiB DDR4 2666 MHz (Winbond W664GG6RB) |
| Flash      | SPI-NAND 256 MiB (Winbond W25N02KV0) |
| WLAN       | MT7916AN + MT7976DN |
| Ethernet   | 1x 2500 Mbps WAN (Airoha EN8811H)<br>4x 10/100/1000 Mbps LAN1–LAN4 (switch tích hợp trong SoC Airoha AN7581) |
| XG-PON     | ECONET EN7572AN, SLIC: MaxLinear PEF32001VSV12 (chỉ có ở bản XSW-250NS) |
| USB        | Không có |
| Nút bấm    | Wi-Fi / Reset / WPS |
| LED        | 1x Power (xanh lá, điều khiển qua GPIO)<br>1x WAN (xanh lá, điều khiển qua GPIO)<br>4x LAN (xanh lá, điều khiển qua GPIO) |
| Nguồn      | 12 VDC, 1 A |

## Các chức năng không hỗ trợ và giới hạn

1. XG-PON sẽ không hoạt động sau khi cài OpenWrt.
2. NPU bị vô hiệu hóa vì chip Wi-Fi hiện chưa hỗ trợ offload.
   **(Không bật Hardware Offloading trong phần Firewall.)**
3. Địa chỉ MAC bị cố định ở giá trị mặc định, do giá trị gốc trong phân vùng factory của stock firmware đã bị mã hóa (encrypted) và không thể đọc ra được.

## Cài đặt / khôi phục (theo cấu trúc U-Boot của OpenWrt)

1. Đảm bảo bạn đã có bản sao lưu firmware gốc (stock rom) trước khi bắt đầu.
2. Đặt các file ảnh OpenWrt lên TFTP server (IP: `192.168.1.254`):
   - `openwrt-airoha-an7581-vnpt_xsw-050ns-bl31-uboot.fip`
   - `openwrt-airoha-an7581-vnpt_xsw-050ns-initramfs-recovery.itb`
   - `openwrt-airoha-an7581-vnpt_xsw-050ns-preloader.bin`
3. Kết nối cổng serial console và mở **Tera Term** trên Windows, thiết lập tốc độ **115200 baud**.
4. Giữ (hold) nút Reset (nằm trong lỗ nhỏ trên vỏ máy) và cắm nguồn để vào chế độ recovery.
5. Nhấn phím `x` trong terminal, sau đó vào **File → Transfer → XMODEM → Send**.
6. Chọn file BL2:
   `openwrt-airoha-an7581-vnpt_xsw-050ns-preloader.bin`
7. Chờ đến khi file được truyền xong và thấy dòng nhắc sau xuất hiện:
   `Press x to load BL31 + U-Boot FIP`
8. Nhấn phím `x` trong terminal, sau đó vào **File → Transfer → XMODEM → Send**.
9. Chọn file FIP:
   `openwrt-airoha-an7581-vnpt_xsw-050ns-bl31-uboot.fip`
10. Chờ đến khi file được truyền xong; U-Boot sẽ tự động chuẩn bị phân vùng UBI.
11. Chờ menu U-Boot hiện ra.
12. Chạy mục **"Load BL31+U-Boot FIP via TFTP then write to NAND"**.
13. Chạy mục **"Load BL2 preloader via TFTP then write to NAND"**.
14. Chạy mục **"Boot system via TFTP"**.
15. Sau khi vào được OpenWrt, thực hiện sysupgrade như bình thường.
16. Tắt thiết bị bằng cách nhấn nút nguồn, sau đó bật lại để khởi động lại.

## Nhật ký thay đổi

- **Phát hành lần đầu** — dựa trên commit OpenWrt [`aac6df7b`](https://github.com/openwrt/openwrt/commit/aac6df7b)

## Tải về

- [openwrt-airoha-an7581-vnpt_xsw-050ns-bl31-uboot.fip](openwrt-xsw-050ns/openwrt-airoha-an7581-vnpt_xsw-050ns-bl31-uboot.fip)
- [openwrt-airoha-an7581-vnpt_xsw-050ns-initramfs-recovery.itb](openwrt-xsw-050ns/openwrt-airoha-an7581-vnpt_xsw-050ns-initramfs-recovery.itb)
- [openwrt-airoha-an7581-vnpt_xsw-050ns-preloader.bin](openwrt-xsw-050ns/openwrt-airoha-an7581-vnpt_xsw-050ns-preloader.bin)
- [openwrt-airoha-an7581-vnpt_xsw-050ns-squashfs-sysupgrade.itb](openwrt-xsw-050ns/openwrt-airoha-an7581-vnpt_xsw-050ns-squashfs-sysupgrade.itb)