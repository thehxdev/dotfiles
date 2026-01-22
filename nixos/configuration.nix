{ config, pkgs, ... }: {

    imports = [
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    
    nix = {
        settings.experimental-features = [ "nix-command" "flakes" ];
        extraOptions = ''
            keep-outputs = true
            keep-derivations = true
        '';
    };
    nixpkgs.config = {
        allowUnfree = true;
    };

    hardware = {
        bluetooth = {
            enable = true;
            powerOnBoot = true;
            settings = {
                General = {
                    Enable = "Source,Sink,Media,Socket";
                };
            };
        };

        graphics.enable = true;

        nvidia = {
            open = true;
            package = config.boot.kernelPackages.nvidiaPackages.production;
            modesetting.enable = true;
            powerManagement.enable = false;
            prime = {
                offload = {
                    enable = true;
                    enableOffloadCmd = true;
                };
                nvidiaBusId = "PCI:01:0:0";
                amdgpuBusId = "PCI:65:0:0";
            };
        };
    };

    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    zramSwap.enable = true;

    networking = {
        hostName = "nixos";
        enableIPv6 = true;
        networkmanager = {
            enable = true;
            dns = "default";
        };
        firewall.enable = false;
        resolvconf.enable = false;
    };
    time.timeZone = "Asia/Tehran";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        enable = true;
        font = "Lat2-Terminus16";
        useXkbConfig = true; # use xkbOptions in tty.
    };

    users = {
        users.hx = {
            isNormalUser = true;
            home = "/home/hx";
            extraGroups = [
                "wheel"
                "video"
                "audio"
                "networkmanager"
                "libvirtd"
                "kvm"
                "qemu-libvirtd"
            ];
        };

        defaultUserShell = pkgs.zsh;
    };

    services = {
        xserver = {
            enable = true;
            videoDrivers = [
                "amdgpu"
                "nvidia"
            ];
        };

        zram-generator.enable = true;

        journald.extraConfig = ''
            SystemMaxUse=25M
            SystemMaxFileSize=10M
        '';

        acpid.enable = true;
        gvfs.enable = true;

        hypridle.enable = true;

        displayManager.sddm = {
            enable = true;
            wayland.enable = false;
        };

        desktopManager.plasma6.enable = true;

        pipewire = {
            enable = true;
            audio.enable = true;
            wireplumber.enable = true;
            alsa.enable = true;
            pulse.enable = true;
        };

        blueman.enable = false;

        libinput = {
            enable = true;
            touchpad = {
                naturalScrolling = true;
                tapping = true;
            };
        };

        flatpak.enable = true;
    };

    programs = {
        nix-ld = {
            enable = true;
            libraries = with pkgs; [
                # Add any missing dynamic libraries for unpackaged programs
            ];
        };
        firefox.enable = true;

        appimage = {
            enable = true;
            binfmt = true;
            package = pkgs.appimage-run.override {
                extraPkgs = pkgs: with pkgs; [
                    # missing libraries here, e.g.: `pkgs.libepoxy`
                ];
            };
        };

        hyprland = {
            enable = true;
            withUWSM = true;
            xwayland.enable = true;
        };
        hyprlock.enable = true;
        uwsm.enable = true;
        waybar.enable = true;

        xwayland.enable = true;

        virt-manager.enable = true;

        git = {
            enable = true;
            config = {
                init = {
                    defaultBranch = "main";
                };
                user = {
                    name = "thehxdev";
                    email = "hossein.khosravi.ce@gmail.com";
                };
            };
        };

        zsh = {
            enable = true;
            enableBashCompletion = true;
            enableCompletion = true;
            histSize = 10000;

            syntaxHighlighting.enable = true;
            ohMyZsh = {
                enable = true;
                plugins = [
                    "git"
                    "sudo"
                ];
                theme = "robbyrussell";
            };
        };

        neovim = {
            enable = true;
            defaultEditor = true;
        };

        yazi = {
            enable = true;
            settings = {
                yazi = {
                    opener = {
                        edit = [ { run = "nvim \"$@\""; block = true; } ];
                        play = [ { run = "flatpak run org.videolan.VLC \"$@\""; orphan = true; } ];
                        open-image = [ { run = "imv \"$@\""; } ];
                        open-pdf = [ { run = "flatpak run org.gnome.Evince \"$@\""; orphan = true; } ];
                    };

                    open = {
                        rules = [
                            { mime = "video/*"; use = "play"; }
                            { mime = "audio/*"; use = "play"; }
                            { mime = "image/*"; use = "open-image"; }
                            { mime = "text/*"; use = "edit"; }
                            { mime = "application/pdf"; use = "open-pdf"; }
                        ];
                    };
                };
            };
        };

        tmux = {
            enable = true;
            historyLimit = 10000;
            keyMode = "vi";
            plugins = with pkgs.tmuxPlugins; [ yank ];
            extraConfig = ''
                set -g allow-passthrough on
                set -ga update-environment TERM
                set -ga update-environment TERM_PROGRAM

                set -s escape-time 0
                set -sa terminal-features ",xterm-*:RGB"

                set -g base-index 1
                set -g pane-base-index 1
                set-window-option -g pane-base-index 1
                set-option -g renumber-windows on

                bind-key -T copy-mode-vi v send-keys -X begin-selection
                bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
            '';
        };

        mtr.enable = true;
        gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
        };
    }; # End programs

    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
            kdePackages.xdg-desktop-portal-kde
            xdg-desktop-portal-hyprland
        ];
    };

    environment = {
        shellAliases = {
            l    = "eza -lha --group-directories-first";
            ll   = "eza -lh --group-directories-first";
            nv   = "nvim";
            tm   = "tmux";
            tma  = "tmux at";
            ip   = "ip -c=auto";
            gitc = "git clone --recurse-submodules --remote-submodules --shallow-submodules -j4 --depth=1";
            blt  = "bluetoothctl";
        };

        variables = {
            EDITOR = "nvim";
            MANPAGER = "nvim +Man!";
        };

        sessionVariables = {};

        systemPackages = with pkgs; [
            kitty

            # CLI tools
            fzf
            ripgrep
            fd
            eza
            curlFull
            distrobox
            aria2
            bat
            jq
            tokei
            htop
            btop
            imv

            ## Archive
            unzip
            zip
            gzip
            zstd

            # Multimedia
            ffmpeg
            x264
            x265
            libvpx
            mpv

            # Hyprland and Wayland related
            hyprpaper
            wl-clipboard
            grim
            wayfreeze
            satty
            slurp
            walker
            brightnessctl

            # Misc.
            usbutils
        ]; # end systemPackages

        plasma6.excludePackages = with pkgs.kdePackages; [
            yakuake
            discover
            cantor
            dragon
            elisa
            gwenview
            kalm
            kalzium
            kate
            kbackup

            # Games
            bovo
            bomber
            granatier
            kanagram
            kapman
            katomic
            kblackbox
            kblocks
            kbounce
            kbreakout
        ];
    };

    virtualisation = {
        podman.enable = true;
        libvirtd.enable = true;
        spiceUSBRedirection.enable = true;
    };

    fonts = {
        enableDefaultPackages = true;
        packages = with pkgs; [ 
            vazir-fonts
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-cjk-serif
            noto-fonts-color-emoji
            font-awesome
            nerd-fonts.iosevka
            nerd-fonts.jetbrains-mono
        ];
        fontconfig = {
            defaultFonts = {
                sansSerif = [ "Noto Sans" "Vazirmatn" ];
                serif = [ "Noto Serif" "Vazirmatn" ];
                monospace = [ "Iosevka Nerd Font" ];
            };
        };
    };

    security = {
        rtkit.enable = true;
        polkit.enable = true;
    };

    qt.enable = true;
    system.stateVersion = "25.11";
}
