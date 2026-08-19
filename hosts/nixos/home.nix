{ config, pkgs, inputs, system, ... }:

{
    # imports
    imports = [
        ../../modules/home/gnome.nix
        ../../modules/home/sway.nix
        ../../modules/home/shell.nix
        ../../modules/home/git.nix
        ../../modules/home/appimage.nix
        ../../modules/home/kitty.nix
        ../../modules/home/distrobox.nix
        ../../modules/home/terminal.nix
    ];

    # home manager basics
    home.username = "oryza";
    home.homeDirectory = "/home/oryza";
    home.stateVersion = "23.11";

    programs.home-manager.enable = true;
    programs.fish.enable = true;
    fonts.fontconfig.enable = true;

    # user packages
    home.packages = with pkgs; [
        # core cli tools
        neovim
        htop
        eza
        fish
        zsh

        # password store (pass + gpg; env vars below)
        pass

        # browsers
        inputs.zen-browser.packages.${system}.default
        vivaldi
        librewolf
        google-chrome

        # gui apps
        libreoffice
        telegram-desktop
        proton-vpn
        blueman
        appimage-run
        figma-linux
        lunacy
        gimp
        gtranslator
        anydesk
        antigravity-ide

        # icons / appearance
        icon-library
        morewaita-icon-theme
        iconic
        blesh

        # utility
        fastfetch
        rar

        # development
        flutter
        android-studio
        uv
        nodejs_22
        svelte-language-server
        github-copilot-cli
        gnome-builder
        opencode
        playerctl

        # rust tooling
        clippy
        rustfmt
    ];

    home.sessionVariables = {
        RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";

        # pass / gpg encryption
        GNUPGHOME = "/home/oryza/.gnupg";
        PASSWORD_STORE_DIR = "/home/oryza/.password-store";
        PASSWORD_STORE_ENABLE_EXTENSIONS = "1";
    };

    # GPG_TTY needs the real tty, so set it in the shell init
    programs.fish.shellInit = ''
        set -gx GPG_TTY (tty)

        # show fastfetch once per terminal startup
        type -q fastfetch; and fastfetch
    '';

    

}
