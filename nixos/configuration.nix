#################################################
# Author: TheHxDev                              #
# Name:   NixOS configuration file              #
#################################################


{ config, pkgs, ... }:

{ 
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/sda"; 
    };
    timeout = 10;
  };

  # Network Manager
  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

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

  # X11 and Xserver settings
  services.xserver = {
    libinput.enable = true;
    libinput.touchpad.tapping = true;

    layout = "us,ir";
    xkbOptions = "eurosign:e,caps:escape,grp:alt_shift_toggle";

    enable = true;
    #videoDrivers = [ "modesetting" ];
    videoDrivers = [ "intel" ];
    deviceSection = ''
      Option "DRI" "2"
      Option "TearFree" "true"
    '';
    #UseGlamor = true;


    displayManager = {
      # KDE
      #sddm.enable = true;
      #defaultSession = "plasma";

      # lightdm
      lightdm.enable = true;

      # XFCE
      defaultSession = "xfce";
    };

    desktopManager = {
      # XFCE
      xfce.enable = true;
      xfce.enableXfwm = true;

      # Cinnamon
      #cinnamon.enable = true;

      # KDE plasma
      #plasma5.enable = true;
    };

    windowManager = {
      #dwm.enable = true;

      #bspwm = {
      #  enable = true;
      #  configFile = "/home/hx/.config/bspwm/bspwmrc";
      #  sxhkd.configFile = "/home/hx/.config/bspwm/sxhkd/sxhkdrc";
      #};

      qtile.enable = true;
      #qtile.configFile = "/home/hx/.config/qtile/config.py";
      qtile.extraPackages = python3Packages: with python3Packages; [
        qtile-extras
      ];

      #xmonad.enable = true;
      #xmonad.enableContribAndExtras = true;
      #xmonad.extraPackages = hpkgs: [
      #  hpkgs.xmonad
      #  hpkgs.xmonad-contrib
      #  hpkgs.xmonad-extras
      #];
    };
  };

  # XFCE Opts
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];

  # Cinnamon Opts
  #services.cinnamon.apps.enable = true;

  ### dwm and dmenu config path
  #nixpkgs.overlays = [
  # (final: prev: {
  #   dwm = prev.dwm.overrideAttrs (old: { src = /home/hx/.dwm/dwm ;});
  #   dmenu = prev.dmenu.overrideAttrs (old: { src = /home/hx/.dwm/dmenu ;});
  # })
  #];

  # GPU acceleration
  hardware.opengl.extraPackages = [
    pkgs.intel-compute-runtime
  ];


  # Fonts
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [ 
      vazir-fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      (nerdfonts.override { fonts = [
        "FiraMono"
        "Mononoki"
        "UbuntuMono"
        "RobotoMono"
        "JetBrainsMono"
        "CascadiaCode"
        ]; })
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Vazirmatn" "Ubuntu" ];
        sansSerif = [ "Vazirmatn" "Ubuntu" ];
        monospace = [ "CaskaydiaCove Nerd Font" ];
      };
    };
  };

  # gvfs
  services.gvfs.enable = true;

  # picom
  services.picom = {
    enable = true;
    fade = false;
    shadow = true;
    backend = "glx";
    vSync = false;
    inactiveOpacity = 1.0;
    activeOpacity = 1.0;
    #settings = {
      #blur =
      #{
        #method = "guassian";
        #size = 7;
        #deviation = 7;
      #};
    #};
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    #extraModules = [ pkgs.pulseaudio-modules-bt ];
    extraConfig = "load-module module-switch-on-connect";
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  services.blueman = {
    enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hx = {
    isNormalUser = true;
    home = "/home/hx";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    #packages = with pkgs; [
    #];
  };

  # VirtualBox
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  #users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  # Fish shell
  #programs.fish.enable = true;
  #users.defaultUserShell = pkgs.fish; # set fish to default shell

  # ZSH shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "man" ];
    };
  };

  users.defaultUserShell = pkgs.zsh;

  # Aliases
  environment.shellAliases = {
    l  = "exa -lha --group-directories-first";
    ll = "exa -lh --group-directories-first";
    nv = "nvim";
    tm = "tmux";
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  # flatpak
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  }

  # QT Themes
  qt.enable = true;
  qt.platformTheme = "qt5ct";

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # tmux
  #programs.tmux = {
  #    enable = true;
  #    terminal = "tmux-256color";
  #    extraConfig = ''
  #    set -s escape-time 0
  #    set -ag terminal-overrides ",*:RGB"
  #    '';
  #};

  # git
  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  #programs.proxychains = {
  #  enable = true;
  #  proxies = {
  #    nekoray = {
  #      type = "socks5";
  #      host = "127.0.0.1";
  #      port = "2080";
  #    };
  #  };
  #};

  environment.systemPackages = with pkgs; [

    # Browsers
    firefox
    #ungoogled-chromium
    #brave

    # Icons
    papirus-icon-theme

    # Editors
    vim 
    neovim
    #emacs

    # Tools
    ripgrep
    fd
    bleachbit
    xarchiver
    exa
    #pcmanfm
    #lxqt.pcmanfm-qt
    libsForQt5.okular
    xfce.mousepad
    xfce.xfce4-terminal
    pavucontrol
    pamixer
    nitrogen
    rofi
    alacritty
    #kitty
    #dmenu
    arandr
    vlc
    mpv
    tmux

    # Others
    #git
    curl
    aria2
    wget
    ffmpeg
    x264
    libvpx
    galculator
    brightnessctl
    xclip
    xsel
    xfce.xfce4-xkb-plugin
    python3Full
    #lxsession
    #lxappearance
    #pfetch
    afetch
    neofetch
    htop
    yt-dlp
    #tdesktop
    viewnior
    xorg.xkill
    #killall
    unrar
    unzip
    gzip
    p7zip
    font-manager
    acpid
    cmake
    gcc
    nodejs
    nodePackages.npm
    flameshot
    xdg-user-dirs
    xdg-utils

    # xorg
    xorg.libX11
    xorg.libXinerama
    xorg.libXft
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilkeysyms
    xorg.xcbutilwm
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
  system.stateVersion = "23.05"; # Did you read the comment?
}

