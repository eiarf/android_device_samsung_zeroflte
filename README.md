Device configuration for Samsung Galaxy S6 (SM-G920F, SM-G920I, SM-G920FD).
========================================

Basic   | Specification List
-------:|:-------------------------
CPU     | 4x2.1 GHz Cortex-A57 & 4x1.5 GHz Cortex-A53)
Chipset | Samsung Exynos 7420
GPU     | Mali-T760 MP8
Memory  | 3 GB
Shipped Android Version | 5.0.2
Storage | 32/64/128 GB
MicroSD | n/A
Battery | Li-Ion 2600 mAh
Dimensions | 143.4 mm x 70.5 mm x 6.8 mm
Display | 2560 x 1440 pixel, 5.1"
Rear Camera  | 16 MP, f/1.9, 28mm (wide), 1/2.6", 1.12µm, AF, OIS
Front Camera | 5 MP, f/1.9, 22mm (wide), 1/4.1", 1.34µm
Release Date | April 2015

![Galaxy S6](https://fdn2.gsmarena.com/vv/pics/samsung/samsung-galaxy-s6-3.jpg "Galaxy S6")

## Android 15 (Kernel 6.6) Status & Fixes

### Working
- Boot to Desktop & System UI (Project Infinity-X 2.9 / Android 15)
- Touchscreen & Capacitive Touchkeys (with screen-off inhibition decoupling)
- 2 GB ZRAM Swap (`lzo-rle`) with kernel module auto-load on boot completion
- Kernel Watchdog (`dsh_esslog`) with automatic disarm upon successful boot
- GPU DVFS floor raised to 420 MHz (boost up to 544 MHz) for smooth 1440x2560 WQXGA rendering
- CPU DVFS floors tuned (Little: 600 MHz, Big: 1000 MHz) with top-app uclamp boost
- Hardware accelerated composition (`debug.sf.hw=1`, blur disabled)
- Wi-Fi, Bluetooth, Audio, Sensors, ADB

### Known Issues
- **Camera**: Upstream kernel 6.6 port currently lacks the Exynos 7420 FIMC-IS camera provider HAL.
