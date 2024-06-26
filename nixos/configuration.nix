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

    # enable sound
    sound.enable = true;

    services = {
        journald.extraConfig = ''
        SystemMaxUse=25M
        SystemMaxFileSize=10M
        '';

        libinput = {
            enable = true;
            touchpad = {
                tapping = true;
            };
        };


        displayManager = {
            sddm.enable = false;
            defaultSession = "none+bspwm";
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
                "modesetting"
            ];

            deviceSection = ''
                Option "DRI" "2"
                Option "TearFree" "true"
            '';


            displayManager = {
                lightdm.enable = true;
            };

            desktopManager = {
                # XFCE
                xfce = {
                    enable = false;
                    enableXfwm = false;
                };

                cinnamon.enable = false;

                plasma5.enable = false;
            };

            windowManager = {
                i3 = {
                   enable = false;
                   configFile = "/home/hx/.config/i3/config";
                   extraPackages = with pkgs; [
                       i3status
                       i3lock
                   ];
                };

                bspwm = {
                    enable = true;
                    configFile = "/home/hx/.config/bspwm/bspwmrc";
                    sxhkd.configFile = "/home/hx/.config/sxhkd/sxhkdrc";
                };
            };
        };

        gvfs.enable = true;

        cinnamon.apps.enable = false;

        # picom
        picom = {
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
           wintypes = {
               dropdown_menu = { shadow = false; blur-background = false; };
               popup_menu    = { shadow = false; blur-background = false; };
               utility       = { shadow = false; blur-background = false; };
               desktop       = { shadow = false; blur-background = false; };
               notification  = { shadow = true;  blur-background = false; };
           };
        };


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
            alsa.enable = true;
            alsa.support32Bit = true;
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
            enable = true;
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
            # autosuggestions.enable = true;
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
        nix-ld = {
            enable = true;
            libraries = options.programs.nix-ld.libraries.default ++ (with pkgs; [
                stdenv.cc.cc
                openssl
                zlib
                libcxx
                # sane-backends

                qt5.qtbase
                qt5.qtsvg
                #qt5.qtwayland
                qt5.qtx11extras
                qt5.qtdeclarative

                xorg.libXcomposite
                xorg.libXtst
                xorg.libXrandr
                xorg.libXext
                xorg.libX11
                xorg.libXfixes
                xorg.libxcb
                xorg.libXdamage
                xorg.libxshmfence
                xorg.libXxf86vm
                xorg.libXinerama
                xorg.libXcursor
                xorg.libXrender
                xorg.libXScrnSaver
                xorg.libXi
                xorg.libSM
                xorg.libICE
                xorg.libXt
                xorg.libXmu
                xorg.libXft

                libjpeg
                libpng
                libGL
                libva
                libxkbcommon
                libdrm
                mesa
                dbus
                libelf
                glib
                gtk2
                bzip2
                cups
                ffmpeg
                freetype
                fontconfig
                alsaLib
            ]);
        };

        slock.enable = true;

        xss-lock = {
            enable = true;
            lockerCommand = "${pkgs.slock}/bin/slock";
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


    hardware = {
        # opengl
        opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
            extraPackages = with pkgs; [
                intel-compute-runtime
                intel-media-driver  # LIBVA_DRIVER_NAME=iHD
                intel-vaapi-driver  # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
                libvdpau-va-gl
            ];
        };

        # nvidie prime
        ## https://nixos.wiki/wiki/Nvidia
        nvidia = {
            package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
            modesetting.enable = true;
            prime = {
                offload = {
                    enable = true;
                    enableOffloadCmd = true;
                };
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
            };
            nvidiaSettings = true;
        };


        # pulseaudio = {
        #     enable = false;
        #     package = pkgs.pulseaudioFull;
        #     #extraModules = [ pkgs.pulseaudio-modules-bt ];
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
        users.hx = {
            isNormalUser = true;
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

            packages = with pkgs; [
                jq
                btop
                # sqlite
                nodePackages.vscode-langservers-extracted
                lua-language-server
                tokei
                # obs-studio
                yt-dlp
            ];
        };

        defaultUserShell = pkgs.zsh;
        # extraGroups.docker.members = [ "hx" ];
    };


    environment = {
        # Aliases
        shellAliases = {
            l   = "eza -lha --group-directories-first";
            ll  = "eza -lh --group-directories-first";
            nv  = "nvim";
            tm  = "tmux";
            tma = "tmux a -t";
            cdp = "cd ~/projects";
            # cat = "bat -p --theme=\"Catppuccin Mocha\""
        };

        # ENV variables
        variables = {
            EDITOR = "nvim";
        };

        sessionVariables = {
            # Force intel-media-driver
            # See hardware opengl section
            LIBVA_DRIVER_NAME = "iHD";
        };


        systemPackages = with pkgs; [

            # office
            #libreoffice-fresh
            #xournalpp

            # virtualization
            # virt-manager
            # spice-gtk

            # Browsers
            firefox
            #brave
            #librewolf
            #chromium
            #ungoogled-chromium

            # Icons, themes and WM
            papirus-icon-theme
            libsForQt5.qtstyleplugins
            libsForQt5.qtstyleplugin-kvantum
            cinnamon.mint-cursor-themes
            adapta-gtk-theme
            polybarFull

            # Editors
            neovim
            tree-sitter
            #helix
            #emacs

            # Terminals and Command-line tools
            # alacritty
            kitty
            ripgrep
            fd
            eza
            tmux
            curlFull
            # aria2
            wget
            htop
            neofetch
            nnn
            bat

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
            usbutils

            # XFCE
            xfce.mousepad
            #xfce.xfce4-xkb-plugin
            xfce.xfce4-clipman-plugin
            #xfce.xfce4-power-manager

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
            python312Packages.pip

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
            # gparted
            # patchelf
            # bleachbit
            # libsForQt5.okular
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
            xdg-launch
            xdg-utils
            dig
            scrcpy

            # Security
            openssl
            # bubblewrap
            pinentry
            wireguard-tools
        ];
    };


    # xdg portal for flatpak
    xdg = {
        mime = {
            enable = true;
            addedAssociations = {
                "application/pdf" = "okularApplication_pdf.desktop";
                "text/html"  = "firefox.desktop";
                "image/png"  = "viewnior.desktop";
                "image/jpeg" = "viewnior.desktop";
                "video/mp4" = [
                    "mpv.desktop"
                        "vlc.desktop"
                ];
                "video/mkv" = [
                    "mpv.desktop"
                        "vlc.desktop"
                ];
            };
            defaultApplications = {
                "application/pdf" = "okularApplication_pdf.desktop";
                "text/html"  = "firefox.desktop";
                "image/png"  = "viewnior.desktop";
                "image/jpeg" = "viewnior.desktop";
                "video/mp4" = "mpv.desktop";
                "video/mkv" = "mpv.desktop";
            };
        };
        portal = {
            enable = true;
            xdgOpenUsePortal = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal
                xdg-desktop-portal-gtk
                xdg-desktop-portal-shana
            ];
        };
    };


    # QT Themes
    qt = {
        enable = true;
        platformTheme = "qt5ct";
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
    system.stateVersion = "24.05"; # Did you read the comment?
}
