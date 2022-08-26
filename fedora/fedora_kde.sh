#! /usr/bin/env bash

# Installing Xorg
sudo dnf install --allowerasing @base-x xset xsetroot xorg-x11-drv-intel xorg-x11-font-utils xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-server-Xorg xorg-x11-server-devel xorg-x11-xfs 

# Install Desktop
sudo dnf install --allowerasing bluedevil breeze-gtk plasma-drkonqi kde-gtk-config kdeplasma-addons kdeplasma-addons-devel kgamma khotkeys khotkeys-devel kinfocenter kscreen ksshaskpass kwallet kwalletmanager5 kwrited oxygen-sounds  plasma-desktop plasma-browser-integration plasma-nm plasma-nm-openvpn plasma-disks plasma-pa plasma-systemmonitor plasma-thunderbolt plasma-vault plasma-workspace plasma-workspace-wallpapers powerdevil sddm sddm-kcm sddm-breeze sddm-x11 xdg-desktop-portal-kde plasma-sdk

# Installing Packages
sudo dnf install --allowerasing pcmanfm-qt firefox papirus-icon-theme gparted ark ark-libs kate kate-plugins kcalc kf5-krunner kfind unrar unzip p7zip viewnior okular okular-libs dbus dbus-libs openvpn spectacle alacritty fish aria2 alsa-plugins-pulseaudio alsa-utils pavucontrol pulseaudio pulseaudio-utils pulseaudio-libs bleachbit gvfs vim neovim

# sudo dnf install --allowerasing kcron ksystemlog

