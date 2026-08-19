{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        appimage-run
    ];

    xdg.desktopEntries = {
        mendeley = {
            name = "Mendeley Reference Manager";
            comment = "Reference management software";
            exec = "appimage-run ${config.home.homeDirectory}/apps/mendley/mendeley-reference-manager-2.144.0-x86_64.AppImage";
            icon = "${config.home.homeDirectory}/apps/mendley/mendley.png";
            terminal = false;
            type = "Application";
            categories = [ "Office" "Education" ];
        };

        deta-surf = {
            name = "Deta Surf";
            comment = "notes keeping and productivity browser";
            exec = "appimage-run ${config.home.homeDirectory}/apps/deta-surf/Surf-1.4.7-beta.0.x86_64.AppImage";
            icon = "${config.home.homeDirectory}/apps/deta-surf/surf.png";
            terminal = false;
            type = "Application";
            categories = [ "Office" "Education" ];
        };
    };
}
