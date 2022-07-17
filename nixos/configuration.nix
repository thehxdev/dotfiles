# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; 
  boot.loader.timeout = 5;

  # Network Manager
  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Asia/Tehran";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    #keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.deviceSection = ''
    Option "DRI" "2"
    Option "TearFree" "true"
  '';

  # Enable the Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "none+xmonad";
  services.xserver.desktopManager.lxqt.enable = true;

  services.xserver.windowManager = {
    #dwm.enable = true;
    bspwm = {
      enable = true;
      configFile = "/home/hx/.config/bspwm/bspwmrc";
      sxhkd.configFile = "/home/hx/.config/bspwm/sxhkd/sxhkdrc";
    };
    qtile.enable = true;
    xmonad.enable = true;
    xmonad.enableContribAndExtras = true;
    xmonad.extraPackages = hpkgs: [
      hpkgs.xmonad
      hpkgs.xmonad-contrib
      hpkgs.xmonad-extras
    ];
  };

  # dwm and dmenu config path
  nixpkgs.overlays = [
   (final: prev: {
     dwm = prev.dwm.overrideAttrs (old: { src = /home/hx/.dwm/dwm ;});
     dmenu = prev.dmenu.overrideAttrs (old: { src = /home/hx/.dwm/dmenu ;});
   })
  ];

  # Fonts
  fonts = {
    enableDefaultFonts = true;
  };

  # gvfs
  services.gvfs.enable = true;

  # picom
  services.picom = {
    enable = true;
    fade = false;
    shadow = true;
    backend = "xrender";
    vSync = false;
    inactiveOpacity = 1.0;
    #activeOpacity = 1.0;
    #settings = {
      #blur =
      #{
        #method = "guassian";
        #size = 7;
        #deviation = 7;
      #};
    #};
  };

  # Configure keymap in X11
  services.xserver.layout = "us,ir";
  services.xserver.xkbOptions = "eurosign:e,caps:escape,grp:alt_shift_toggle";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.tapping = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hx = {
    isNormalUser = true;
    home = "/home/hx/";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    packages = with pkgs; [
      # Browsers
      firefox
      brave
      bleachbit

      # GTK themes
      materia-theme
      pop-gtk-theme

      # Icons
      pop-icon-theme
      papirus-icon-theme

      # Others
      nodejs
      xarchiver
      cinnamon.xreader
      flameshot
      xdg-user-dirs
      xdg-utils
      nodePackages.npm
      trayer
      polybar
      haskellPackages.xmobar
    ];
  };

  # VirtualBox
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  #users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  # Fish shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  
  # QT Themes
  programs.qt5ct.enable = true;

  # GPU acceleration
  hardware.opengl.extraPackages = [
    pkgs.intel-compute-runtime
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # Editors
    vim 
    neovim
    emacs
    ripgrep
    fd

    # Tools
    nitrogen
    rofi
    alacritty
    kitty
    dmenu
    arandr
    vlc
    mpv

    # Others
    git
    aria2
    curl
    wget
    ffmpeg
    x264
    libvpx
    galculator
    brightnessctl
    xclip
     #xfce.xfce4-xkb-plugin
    python3Full
    lxsession
    lxappearance
    pfetch
    neofetch
    yt-dlp
    tdesktop
    viewnior
    xorg.xkill
    killall
    unrar
    unzip
    gzip
    p7zip
    font-manager
    acpid
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

