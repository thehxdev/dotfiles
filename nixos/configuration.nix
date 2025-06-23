#################################################
# Author: TheHxDev                              #
# Name:   NixOS configuration file              #
#################################################


{ config, pkgs, options, ... }:

{ 
    imports = [ 
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

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
        nixos.enable = true;
        dev.enable = true;
    };


    # Use the GRUB 2 boot loader.
    boot = {
        supportedFilesystems = {
            ntfs = true;
        };
        loader = {
            grub = {
                enable = true;
                # EDITME: set the boot device
                device = "/dev/nvme0n1"; 
            };
            timeout = 10;
        };
    };

    services = {
        journald.extraConfig = ''
        SystemMaxUse=25M
        SystemMaxFileSize=10M
        '';

        acpid.enable = true;

        libinput = {
            enable = true;
            touchpad = {
                tapping = true;
            };
        };

        desktopManager.plasma6.enable = true;
        displayManager.sddm = {
            enable = true;
            wayland.enable = true;
        };

        # X11 and Xserver settings
        xserver = {
            enable = true;

            xkb = {
                layout = "us,ir";
                options = "eurosign:e,caps:escape,grp:alt_shift_toggle";
            };

            videoDrivers = [
                # "intel"
                # "modesetting"
                "amdgpu"
                "nvidia"
            ];

            # deviceSection = ''
            #     Option "DRI" "2"
            #     Option "TearFree" "true"
            # '';


            # displayManager = {
            #     lightdm.enable = false;
            # };

            # windowManager = {
            #     i3 = {
            #         enable = false;
            #         configFile = "/home/hx/.config/i3/config";
            #         extraPackages = with pkgs; [
            #             i3status
            #             i3lock
            #         ];
            #     };
            #
            #     bspwm = {
            #         enable = false;
            #         configFile = "/home/hx/.config/bspwm/bspwmrc";
            #         sxhkd.configFile = "/home/hx/.config/sxhkd/sxhkdrc";
            #     };
            # };
        };

        gvfs.enable = true;

        # cinnamon.apps.enable = false;

        # picom
        # picom = {
        #     enable = false;
        #     fade = false;
        #     shadow = false;
        #     backend = "glx";
        #     vSync = false;
        #     inactiveOpacity = 1.0;
        #     activeOpacity = 1.0;
        #     settings = {
        #         blur = {
        #             method = "gaussian";
        #             size = 15;
        #             deviation = 15;
        #         };
        #     };
        #     wintypes = {
        #         dropdown_menu = { shadow = false; blur-background = false; };
        #         popup_menu    = { shadow = false; blur-background = false; };
        #         utility       = { shadow = false; blur-background = false; };
        #         desktop       = { shadow = false; blur-background = false; };
        #         notification  = { shadow = true;  blur-background = false; };
        #     };
        # };


        # Enable CUPS for printing.
        printing = {
            enable = true;
            drivers = with pkgs; [ canon-cups-ufr2 ];
        };
        avahi = {
            enable = true;
            nssmdns4 = true;
            nssmdns6 = false;
        };

        pipewire = {
            enable = true;
            audio.enable = true;
            wireplumber.enable = true;
            alsa.enable = true;
            alsa.support32Bit = false;
            pulse.enable = true;
            jack.enable = false;
        };

        blueman.enable = false;

        flatpak.enable = true;

        gnome.gnome-keyring.enable = true;

        emacs.enable = false;

        openssh.enable = true;
    };

    programs = {
        # Thunar options
        thunar = {
            enable = false;
            plugins = with pkgs.xfce; [
                thunar-archive-plugin
                thunar-volman
            ];
        };

        # ZSH shell
        zsh = {
            enable = true;
            enableCompletion = true;
            syntaxHighlighting.enable = true;
            autosuggestions.enable = false;
            ohMyZsh = {
                enable = true;
                theme = "robbyrussell";
                plugins = [
                    "git"
                    "sudo"
                ];
            };
        };

        git = {
            enable = true;
            config = {
                user = {
                    # EDITME: git user and email
                    name = "";
                    email = "";
                };
                core = {
                    editor = "nvim";
                    autocrlf = "input";
                };
                init = {
                    defaultBranch = "main";
                };
            };
        };

        # for virtualisation and kvm
        dconf.enable = true;

        # Some programs need SUID wrappers, can be configured further or are
        # started in user sessions.
        mtr.enable = false;
        gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
            pinentryPackage = pkgs.pinentry-curses;
        };

        # https://unix.stackexchange.com/a/522823
        # nix-ld = {
        #     enable = true;
        #     libraries = options.programs.nix-ld.libraries.default ++ (with pkgs; [
        #         stdenv.cc.cc
        #         openssl
        #         zlib
        #         libcxx
        #         # sane-backends
        #
        #         qt5.qtbase
        #         qt5.qtsvg
        #         #qt5.qtwayland
        #         qt5.qtx11extras
        #         qt5.qtdeclarative
        #
        #         xorg.libXcomposite
        #         xorg.libXtst
        #         xorg.libXrandr
        #         xorg.libXext
        #         xorg.libX11
        #         xorg.libXfixes
        #         xorg.libxcb
        #         xorg.libXdamage
        #         xorg.libxshmfence
        #         xorg.libXxf86vm
        #         xorg.libXinerama
        #         xorg.libXcursor
        #         xorg.libXrender
        #         xorg.libXScrnSaver
        #         xorg.libXi
        #         xorg.libSM
        #         xorg.libICE
        #         xorg.libXt
        #         xorg.libXmu
        #         xorg.libXft
        #
        #         libjpeg
        #         libpng
        #         libGL
        #         libva
        #         libxkbcommon
        #         libdrm
        #         mesa
        #         dbus
        #         libelf
        #         glib
        #         gtk2
        #         bzip2
        #         cups
        #         ffmpeg
        #         freetype
        #         fontconfig
        #         alsaLib
        #     ]);
        # };

        slock.enable = false;

        xss-lock = {
            enable = false;
            lockerCommand = "${pkgs.slock}/bin/slock";
        };

        appimage.enable = true;
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


    hardware = {
        # graphics
        graphics = {
            enable = true;
            # extraPackages = with pkgs; [
            #     intel-compute-runtime
            #     intel-media-driver  # LIBVA_DRIVER_NAME=iHD
            #     intel-vaapi-driver  # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
            #     libvdpau-va-gl
            # ];
        };

        # nvidie prime
        ## https://nixos.wiki/wiki/Nvidia
        nvidia = {
            package = config.boot.kernelPackages.nvidiaPackages.production;
            modesetting.enable = true;
            prime = {
                offload = {
                    enable = true;
                    enableOffloadCmd = true;
                };
                # intelBusId = "PCI:0:2:0";
                amdgpuBusId = "PCI:65:0:0";
                nvidiaBusId = "PCI:1:0:0";
            };
            powerManagement.finegrained = false;
            open = true;
            nvidiaSettings = true;
        };


        # pulseaudio = {
        #     enable = false;
        #     package = pkgs.pulseaudioFull;
        #     # extraModules = [ pkgs.pulseaudio-modules-bt ];
        #     extraConfig = "load-module module-switch-on-connect";
        # };

        bluetooth = {
            enable = true;
            powerOnBoot = true;
            settings = {
                General = {
                    Enable = "Source,Sink,Media,Socket";
                };
            };
        };
    };


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
                # "FiraMono"
                # "Mononoki"
                # "UbuntuMono"
                # "RobotoMono"
                "JetBrainsMono"
                # "CascadiaCode"
            ]; })
        ];
        fontconfig = {
            defaultFonts = {
                serif = [ "Vazirmatn" "Ubuntu Nerd Font" ];
                sansSerif = [ "Vazirmatn" "Ubuntu Nerd Font" ];
                monospace = [ "JetBrainsMono Nerd Font" ];
            };
        };
    };


    security = {
        rtkit.enable = true;
        polkit.enable = true;
    };


    # Define a user account.
    # Don't forget to set a password with ‘passwd’.
    users = {
        # EDITME: set username and configure user settings
        users.hx = {
            enbale = true;
            isNormalUser = true;
            createHome = false;
            home = "/home/hx";
            extraGroups = [
                "wheel"
                "audio"
                "video"
                "users"
                "networkmanager"
                # "kvm"
                # "libvirtd"
                # "docker"
                # "vboxusers"
            ];

            # packages = with pkgs; [
            # ];
        };

        defaultUserShell = pkgs.zsh;
        # extraGroups.docker.members = [ "hx" ];
    };


    environment = {
        # Aliases
        shellAliases = {
            l    = "eza -lha --group-directories-first";
            ll   = "eza -lh --group-directories-first";
            nv   = "nvim";
            tm   = "tmux";
            tma  = "tmux a -t";
            cdp  = "cd ~/projects";
            ip   = "ip -c=auto";
            gitc = "git clone --recurse-submodules --remote-submodules --shallow-submodules -j4 --depth=1"
        };

        # ENV variables
        variables = {
            EDITOR = "nvim";
            MANPAGER = "nvim +Man!"
        };

        sessionVariables = {
            # Force intel-media-driver
            # See hardware opengl section
            # LIBVA_DRIVER_NAME = "iHD";
        };


        systemPackages = with pkgs; [
            ## office
            # libreoffice-fresh
            # xournalpp

            ## virtualization
            # virt-manager
            # spice-gtk

            ## Browsers
            firefox
            # brave
            # librewolf
            # chromium
            # ungoogled-chromium

            ## Icons, themes and WM
            # papirus-icon-theme
            # libsForQt5.qtstyleplugins
            # libsForQt5.qtstyleplugin-kvantum
            # cinnamon.mint-cursor-themes
            # adapta-gtk-theme
            # polybarFull

            ## Editors
            neovim
            tree-sitter
            # helix
            # emacs

            ## Terminals and Command-line tools
            # alacritty
            kitty
            ripgrep
            fd
            eza
            tmux
            curlFull
            aria2
            wget
            htop
            # neofetch
            nnn
            bat
            jq
            btop
            # sqlite
            tokei


            ## Multi media
            pavucontrol
            pamixer
            arandr
            vlc
            mpv
            ffmpeg
            x264
            x265
            libvpx
            usbutils
            yt-dlp
            # obs-studio

            ## XFCE
            # xfce.mousepad
            # xfce.xfce4-xkb-plugin
            # xfce.xfce4-clipman-plugin
            # xfce.xfce4-power-manager

            ## Archive
            rar
            # unrar
            unzip
            zip
            gzip
            p7zip
            zstd

            ## dev
            # man-pages
            # rlwrap
            lua-language-server

            ## Python
            python313Full
            python313Packages.pip

            ## NodeJS
            nodejs
            nodePackages.npm
            nodePackages.vscode-langservers-extracted

            ## Java
            # jdk

            ## xorg
            xorg.xcbutil
            xorg.xcbutilkeysyms
            xorg.xcbutilwm
            xorg.xkill
            xclip
            xsel

            ## wayland
            wayland-utils
            wl-clipboard

            ## Tools
            jcal
            # gparted
            # patchelf
            # bleachbit
            # libsForQt5.okular
            # nitrogen
            # rofi
            # galculator
            # brightnessctl
            # lxsession
            # lxappearance
            # viewnior
            font-manager
            flameshot
            xdg-user-dirs
            xdg-launch
            xdg-utils
            dig
            # scrcpy

            ## Security
            openssl
            # bubblewrap
            # pinentry
            wireguard-tools
        ];
    };


    # xdg portal for flatpak
    xdg = {
        mime = {
            enable = true;
            # addedAssociations = {
            #     "application/pdf" = "okularApplication_pdf.desktop";
            #     "text/html"  = "firefox.desktop";
            #     "image/png"  = "viewnior.desktop";
            #     "image/jpeg" = "viewnior.desktop";
            #     "video/mp4" = [
            #         "mpv.desktop"
            #         "vlc.desktop"
            #     ];
            #     "video/mkv" = [
            #         "mpv.desktop"
            #         "vlc.desktop"
            #     ];
            # };
            # defaultApplications = {
            #     "application/pdf" = "okularApplication_pdf.desktop";
            #     "text/html"  = "firefox.desktop";
            #     "image/png"  = "viewnior.desktop";
            #     "image/jpeg" = "viewnior.desktop";
            #     "video/mp4" = "mpv.desktop";
            #     "video/mkv" = "mpv.desktop";
            # };
        };
        portal = {
            enable = true;
            xdgOpenUsePortal = true;
            config.common.default = "*";
            # extraPortals = with pkgs; [
            #     xdg-desktop-portal
            #     xdg-desktop-portal-gtk
            #     xdg-desktop-portal-shana
            # ];
        };
    };


    # QT Themes
    qt = {
        enable = true;
        platformTheme = "gnome";
        style = "adwaita-dark";
    };

    # virtualization
    virtualisation = {
        libvirtd = {
            enable = true;
        };
        spiceUSBRedirection.enable = true;
        docker.enable = false;
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?
}
