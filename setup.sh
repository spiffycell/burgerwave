#!/bin/bash

set -eEu
set -o pipefail

echo "[*] Starting script..."
echo "[*] Copying folders to plymouth theme directory..."
sudo cp --recursive burgerwave-logo burgerwave-text /usr/share/plymouth/themes/
echo "[*] Linking theme as default..."
sudo ln -sf /usr/share/plymouth/themes/burgerwave-logo/burgerwave-logo.plymouth /etc/alternatives/default.plymouth
sudo ln -sf /usr/share/plymouth/themes/burgerwave-text/burgerwave-text.plymouth /etc/alternatives/text.plymouth

if command -v cryptsetup &>/dev/null
then
	echo "[*] Cryptsetup found!"
	echo "[*] Modifying cryptsetup files..."
	sudo cp cryptsetup-mods/functions /usr/lib/cryptsetup/
	sudo cp cryptsetupmods/cryptroot /usr/share/initramfs-tools/scripts/local-top/
	echo "[*] Handing system file ownership back to root..."
	sudo chown -R root:root /usr/lib/cryptsetup/functions
	sudo chown -R root:root /usr/share/initramfs-tools/scripts/local-top/cryptroot	
	echo "[*] Modifications complete!"
fi

echo "[*] Updating initramfs..."
sudo update-initramfs -u


