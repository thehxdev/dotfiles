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

    # Allow unfree packages
    nixpkgs.config = {
        allowUnfree = true;
    };

    # nix config
    nix = {
        settings.experimental-features = [ "nix-command" "flakes" ];
        extraOptions = ''
            keep-outputs = true
            keep-derivations = true
        '';
    };


    # enable man-db
    documentation.man = {
        enable = true;
        man-db = {
            enable = true;
        };
    };


    # Use the GRUB 2 boot loader.
    boot = {
        supportedFilesystems = [
            "ntfs"
        ];
        loader = {
            grub = {
                enable = true;
                device = "/dev/sda"; 
            };
            timeout = 10;
        };
    };


    # Network Manager
    networking = {
        hostName = "nixos"; 

        networkmanager = {
            enable = true;
            dns = "default";
        };

        resolvconf = {
            enable = false;
        };

        # hosts = {};
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
        useXkbConfig = true; # use xkbOptions in tty.
    };


    # opengl
    hardware.opengl = {
       enable = true;
       driSupport = true;
       driSupport32Bit = true;
    };

    # GPU acceleration
    hardware.opengl.extraPackages = [
        pkgs.intel-compute-runtime
    ];

    # nvidie prime
    ## https://nixos.wiki/wiki/Nvidia
    #hardware.nvidia = {
    #    package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
    #    modesetting.enable = true;
    #    prime = {
    #        offload = {
    #            enable = true;
    #            enableOffloadCmd = true;
    #        };
    #        intelBusId = "PCI:0:2:0";
    #        nvidiaBusId = "PCI:1:0:0";
    #    };
    #    nvidiaSettings = true;
    #};


    # X11 and Xserver settings
    services.xserver = {
        enable = true;

        # enable touchpad
        libinput.enable = true;
        libinput.touchpad.tapping = true;

        layout = "us,ir";
        xkbOptions = "eurosign:e,caps:escape,grp:alt_shift_toggle";

        #videoDrivers = [
        #    #"intel"
        #    "modesetting"
        #];

        #deviceSection = ''
        #    Option "DRI" "2"
        #    Option "TearFree" "true"
        #'';


        displayManager = {
            # sddm for KDE
            #sddm.enable = true;

            # lightdm
            lightdm.enable = true;

            # default session
            defaultSession = "none+bspwm";
        };

        desktopManager = {
            # XFCE
            xfce = {
                enable = true;
                enableXfwm = true;
            };

            # Cinnamon
            #cinnamon.enable = true;

            # KDE plasma
            #plasma5.enable = true;
        };

        windowManager = {
            # i3
            i3 = {
               enable = true;
               configFile = "/home/hx/.config/i3/config";
               extraPackages = with pkgs; [
                   i3status
                   i3lock
               ]
            };

            
            # BSPWM
            bspwm = {
             enable = true;
             configFile = "/home/hx/.config/bspwm/bspwmrc";
             sxhkd.configFile = "/home/hx/.config/bspwm/sxhkd/sxhkdrc";
            };
        };
    };


    # Thunar Options
    programs.thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
            thunar-archive-plugin
            thunar-volman
        ];
    };


    # gvfs
    services.gvfs.enable = true;


    # Cinnamon Opts
    #services.cinnamon.apps.enable = true;
    

    # Fonts
    fonts = {
        enableDefaultPackages = true;
        packages = with pkgs; [ 
            vazir-fonts
            noto-fonts
            noto-fonts-cjk
            noto-fonts-emoji
            font-awesome
            (nerdfonts.override { fonts = [
             "Ubuntu"
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
                serif = [ "Vazirmatn" "Ubuntu Nerd Font" ];
                sansSerif = [ "Vazirmatn" "Ubuntu Nerd Font" ];
                monospace = [ "CaskaydiaCove Nerd Font" ];
            };
        };
    };


    # picom
    services.picom = {
       enable = true;
       fade = false;
       shadow = false;
       backend = "glx";
       vSync = false;
       inactiveOpacity = 1.0;
       activeOpacity = 1.0;
       settings = {
          blur = {
              method = "gaussian";
              size = 15;
              deviation = 15;
          };
       };
    };


    # Enable CUPS to print documents.
    services.printing = {
        enable = true;
        #drivers = with pkgs; [ canon-cups-ufr2 ];
    };
    services.avahi = {
        enable = true;
        nssmdns = true;
    };


    # Enable sound.
    sound.enable = true;

    # pipewire
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;
    };

    # pulseaudio
    # hardware.pulseaudio = {
    #     enable = true;
    #     package = pkgs.pulseaudioFull;
    #     #extraModules = [ pkgs.pulseaudio-modules-bt ];
    #     extraConfig = "load-module module-switch-on-connect";
    # };


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


    # services.blueman = {
    #     enable = true;
    # };


    # Define a user account.
    # Don't forget to set a password with ‘passwd’.
    users.users.hx = {
        isNormalUser = true;
        home = "/home/hx";
        extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "video"
        # "libvirtd"
        # "docker"
        # "vboxusers"
        ];

        # packages = with pkgs; [
        # ];
    };


    # ZSH shell
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        #autosuggestions.enable = true;
        ohMyZsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [ "git" ];
        };
    };
    users.defaultUserShell = pkgs.zsh;

    # Aliases
    environment.shellAliases = {
        l  = "eza -lha --group-directories-first";
        ll = "eza -lh --group-directories-first";
        nv = "nvim";
        tm = "tmux";
        # cdp  = "cd ~/projects";
    };

    # ENV variables
    environment.variables = {
        EDITOR = "nvim";
    };


    # flatpak
    services.flatpak.enable = true;
    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
        ];
    };


    # QT Themes
    qt.enable = true;
    qt.platformTheme = "qt5ct";


    # git
    programs.git = {
        enable = true;
        config = {
            init = {
                defaultBranch = "main";
            };
        };
    };


    # Qemu / Virtualization
    # virtualisation.libvirtd = {
    #   enable = true;
    # };
    # programs.dconf.enable = true;
    # virtualisation.spiceUSBRedirection.enable = true;


    # Security
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;


    # docker
    # virtualization.docker.enable = true;
    # users.extraGroups.docker.members = [ "hx" ];


    # emacs
    # services.emacs.enable = true;


    # system packages
    environment.systemPackages = with pkgs; [

        # office
        #libreoffice-fresh
        #xournalpp

        # virtualization
        #virt-manager
        #spice-gtk

        # Browsers
        firefox
        #brave
        #librewolf
        #chromium
        #ungoogled-chromium

        # Icons, themes and WM
        papirus-icon-theme
        libsForQt5.qtstyleplugin
        libsForQt5.qtstyleplugin-kvantum
        cinnamon.mint-cursor-themes
        adapta-gtk-theme
        polybarFull

        # Editors
        neovim
        tree-sitter
        #emacs

        # Terminals and Command-line tools
        alacritty
        ripgrep
        fd
        eza
        tmux
        curlFull
        aria2
        wget
        htop
        neofetch
        yt-dlp

        # Multi media
        pavucontrol
        pamixer
        arandr
        vlc
        mpv
        ffmpeg
        x264
        x265
        libvpx

        # XFCE
        xfce.mousepad
        #xfce.xfce4-xkb-plugin
        xfce.xfce4-clipman-plugin

        # Archive
        rar
        # unrar
        unzip
        zip
        gzip
        p7zip
        zstd

        # Dev
        man-pages
        # rlwrap

        ## Python
        python312Full

        ## NodeJS
        nodejs
        nodePackages.npm

        ## Java
        jdk

        # xorg
        xorg.xcbutil
        xorg.xcbutilkeysyms
        xorg.xcbutilwm
        xorg.xkill
        xclip
        xsel

        # Tools
        jcal
        gparted
        patchelf
        bleachbit
        libsForQt5.okular
        nitrogen
        rofi
        galculator
        brightnessctl
        lxsession
        lxappearance
        viewnior
        font-manager
        acpid
        flameshot
        xdg-user-dirs
        xdg-utils
        dig

        # Security
        openssl
        bubblewrap
        pinentry
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    #programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryFlavor = "curses";
    };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    #networking.firewall.allowedTCPPorts = [ ... ];
    #networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    #networking.firewall.enable = false;

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
    system.stateVersion = "23.11"; # Did you read the comment?
}

