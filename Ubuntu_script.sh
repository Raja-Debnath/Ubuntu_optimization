#!/bin/bash

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing performance tools..."
sudo apt install -y gnome-tweaks zram-tools preload tlp thunar curl wget git

echo "Disabling GNOME animations..."
gsettings set org.gnome.desktop.interface enable-animations false

echo "Enabling ZRAM..."
sudo systemctl enable --now zramswap.service

echo "Installing lightweight apps..."
sudo apt install -y abiword gnumeric audacious mpv claws-mail

echo "Installing VS Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
rm microsoft.gpg

echo "Installing Node.js (LTS)..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

echo "Installing Python and pip..."
sudo apt install -y python3 python3-pip

echo "Installing Brave Browser..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave.com/signing-key.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | \
  sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install -y brave-browser

  echo "Optimizing startup services..."
  sudo systemctl disable cups.service 2>/dev/null

  echo "All set! Reboot recommended."
  