#! /bin/bash

sudo pacman -Sy --needed --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings qtile nitrogen picom pcmanfm lxappearance materia-gtk-theme papirus-icon-theme archlinux-wallpapre arc-gtk-theme rofi alacritty kitty volumeicon networkmanager-applet alsa-utils unrar unzip p7zip xarchiver openvpn networkmanater-openvpn python-pip bashtop htop geany vim xreader ttf-roboto ttf-roboto-mono ttf-font-awesome bleachbit go
# install yay
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R  hx:hx yay
cd yay
makepkg -si

yay -S nerd-fonts-mononoki ttf-mononoki pfetch samim-fonts

# pip install psutil
