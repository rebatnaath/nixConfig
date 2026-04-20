{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        appimage-run # Required to actually execute the AppImages
    ];

    xdg.desktopEntries = {
        # Mendeley Reference Manager
        mendeley = {
            name = "Mendeley Reference Manager";
            comment = "Reference management software";
            exec = "appimage-run ${config.home.homeDirectory}/apps/mendley/mendeley-reference-manager-2.144.0-x86_64.AppImage";
            icon = "${config.home.homeDirectory}/apps/mendley/mendley.png";
            terminal = false;
            type = "Application";
            categories = [ "Office" "Education" ];
        };
    };
}