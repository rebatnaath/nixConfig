{ config, pkgs, inputs, system, ... }:

{
    # Modular Imports
    imports = [
    ../../modules/home/gnome.nix
    ../../modules/home/shell.nix
    ../../modules/home/git.nix
    ../../modules/home/appimage.nix
];

    # Home Manager Basic Information
    home.username = "oryza";
    home.homeDirectory = "/home/oryza";
    home.stateVersion = "23.11";

    programs.home-manager.enable = true;

    # Packages for the user profile
    home.packages = with pkgs; [
        # Core CLI Tools
        git
        neovim
        htop
        eza
        fastfetch

        # Browsers & Special Inputs
        inputs.zen-browser.packages.${system}.default
        inputs.antigravity-nix.packages.${system}.google-antigravity-no-fhs

        # General Softwares    
        anydesk
        libreoffice
        telegram-desktop
        protonvpn-gui
    ];
}