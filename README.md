# Qtile-Dotfiles
My Qtile DotFiles

# install deps:
you can install by runing qtile-install.sh or with this command:
```sh
sudo pacman -Sy --needed --noconfirm xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings qtile nitrogen picom pcmanfm lxappearance materia-gtk-theme papirus-icon-theme archlinux-wallpapre arc-gtk-theme rofi alacritty kitty volumeicon networkmanager-applet alsa-utils unrar unzip p7zip xarchiver openvpn networkmanater-openvpn python-pip bashtop htop geany vim xreader ttf-roboto ttf-roboto-mono ttf-font-awesome ttf-ubuntu-font-family nerd-fonts-fira-code ttf-fira-code bleachbit gvfs ntfs-3g vi vim nano galculator brightnessctl font-manager sxiv yt-dlp xorg-xclipboard xclip polkit lxsession xdg-user-dirs feh acpid neovim jedi-language-server curl wget go ripgrep fd python-pip 
```
# install yay:
```sh
cd $HOME/
sudo pacman -Sy --noconfirm --needed base-devel git
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R  hx:hx yay
cd yay
makepkg -si
```
# install some aur pkgs:
```sh
yay -Sy flameshot xcursor-breeze nerd-fonts-mononoki ttf-mononoki pfetch samim-fonts
```
