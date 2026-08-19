{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    # home manager
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";

        users.oryza = import ./home.nix;
    };

    # boot
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # higher file-watch limits for watchman etc.
    boot.kernel.sysctl = {
        "fs.inotify.max_user_watches" = 524288;
        "fs.inotify.max_user_instances" = 512;
    };

    # networking
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    networking.firewall.allowedTCPPorts = [ 8081 ];
    networking.firewall.allowedUDPPortRanges = [
        { from = 50000; to = 65535; } # webrtc ports for calls
    ];

    # localisation
    time.timeZone = "Asia/Kathmandu";

    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_IN";
        LC_IDENTIFICATION = "en_IN";
        LC_MEASUREMENT = "en_IN";
        LC_MONETARY = "en_IN";
        LC_NAME = "en_IN";
        LC_NUMERIC = "en_IN";
        LC_PAPER = "en_IN";
        LC_TELEPHONE = "en_IN";
        LC_TIME = "en_IN";
    };

    # graphics / desktop
    services.xserver.enable = true;
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;

    # swayfx adds blur, rounded corners and shadows
    programs.sway = {
        enable = true;
        package = pkgs.swayfx;
        xwayland.enable = true;
        wrapperFeatures.gtk = true;
    };

    environment.sessionVariables = {
        RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
    };

    # hardware / removable media
    # mount exfat drives with correct ownership
    services.udisks2 = {
        enable = true;
        settings = {
            "mount_options.conf" = {
                "exfat_defaults" = {
                    "defaults" = "uid=1000,gid=1000,dmask=0000,fmask=0000,iocharset=utf8";
                };
            };
        };
    };

    # sound
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # printing
    services.printing.enable = true;

    # virtualisation
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    # podman backend for distrobox
    virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
    };

    # user
    users.users.oryza = {
        isNormalUser = true;
        description = "Rohan";
        shell = pkgs.bashInteractive;
        extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "adbusers" ];

        # dev toolchains for the whole system
        
        packages = with pkgs; [
            android-tools
            openjdk17
            dotnet-sdk_8
            texliveFull
            vscodium
            rustc
            rustPlatform.rustLibSrc
            rust-analyzer
            rustlings
            cargo
            gcc
            clang
            cmake
            pkg-config
            gnumake
            gdb
            watchman
            python3
        ];
    };

    # interop
    programs.nix-ld.enable = true;
    programs.fish.enable = true;
    environment.shells = [ pkgs.fish ];

    # firefox with fx-autoconfig for userChromeJS support
    programs.firefox = {
        enable = true;
        package = pkgs.firefox.overrideAttrs (old: {
            fxAutoconfig = pkgs.fetchFromGitHub {
                owner = "MrOtherGuy";
                repo = "fx-autoconfig";
                rev = "dfdab5684faffc112b76ccb1d8cab7f75da0102c";
                sha256 = "0kjqpn49kqwg80vdfqr5d6w1pspdwl0lbb5xdn59ikgwy3ysv4vf";
            };
            buildCommand = (old.buildCommand or "") + ''
                cp "$fxAutoconfig/program/config.js" "$out/lib/firefox/config.js"
                mkdir -p "$out/lib/firefox/defaults/pref"
                cp "$fxAutoconfig/program/defaults/pref/config-prefs.js" "$out/lib/firefox/defaults/pref/config-prefs.js"
            '';
        });
        nativeMessagingHosts.packages = [ pkgs.firefoxpwa ];
    };

    programs.gnupg.agent = {
        enable = true;
        # enableSSHSupport = true;
    };

    # unlock the same gnome keyring for gdm sessions
    security.pam.services.gdm-password.enableGnomeKeyring = true;

    # nix
    nixpkgs.config.allowUnfree = true;

    # node 20 reached eol; keep it to satisfy legacy deps
    nixpkgs.config.permittedInsecurePackages = [
        "nodejs-20.20.2"
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # system packages
    environment.systemPackages = with pkgs; [
        pkgs.firefoxpwa

        # sway screenshot tooling
        pkgs.grim
        pkgs.slurp
    ];

    # fonts
    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        liberation_ttf
        fira-code
        jetbrains-mono

        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        nerd-fonts.geist-mono

        source-code-pro
        hack-font
        inconsolata
        roboto-mono
        cascadia-code
        ibm-plex
        googlesans-code
        geist-font
    ];

    fonts.fontconfig = {
        defaultFonts = {
            serif = [ "Noto Serif" "Noto Serif Devanagari" ];
            sansSerif = [ "Noto Sans" "Noto Sans Devanagari" ];
            monospace = [ "JetBrainsMono Nerd Font" ];
        };
    };

    # xdg portals
    xdg.portal = {
        enable = true;
        extraPortals = [
            pkgs.xdg-desktop-portal-wlr
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-gnome
        ];
    };

    system.stateVersion = "25.11";
}