# After installation

- Computer doesn't restart/logout: `nouveau.modeset = 0`
- Audio
- Killer WiFi 1650 card
- Touchpad, multi-touch gesture

```
sudo apt-get install xserver-xorg-input-libinput
sudo apt-get remove --purge xserver-xorg-input-synaptics
sudo reboot
```

- Improve battery life

```
sudo apt update
sudo apt install tlp tlp-rdw powertop
sudo tlp start
sudo powertop --auto-tune
sudo reboot
```
- Bluetooth
- Screen brightness
- Keyboard backlight
- NVIDIA Drivers
- Fingerprint reader
- Thunderbolt
