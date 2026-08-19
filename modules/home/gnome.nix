{ pkgs, config, ... }:

{
    home.packages = with pkgs; [
        gnome-tweaks
        gnome-boxes
        gnomeExtensions.blur-my-shell
        gnomeExtensions.just-perfection
        gnomeExtensions.clipboard-history
        gnomeExtensions.dash-to-dock
        gnomeExtensions.rounded-window-corners-reborn
        gnomeExtensions.user-themes
        gnomeExtensions.caffeine
        gnomeExtensions.pip-on-top
        gnomeExtensions.wallpaper-slideshow
    ];

    home.pointerCursor = {
        enable = true;
        x11.enable = true;
        name = "WhiteSur-cursors";
        size = 24;
        package = pkgs.whitesur-cursors;
    };

    gtk = {
        enable = true;
        gtk4.theme = null;

        font = {
            name = "SF Pro Display";
            size = 11;
        };

        iconTheme = {
            name = "MoreWaita";
            package = pkgs.morewaita-icon-theme;
        };

        cursorTheme = {
            name = "WhiteSur-cursors";
            size = 24;
        };
    };

   dconf = {
        enable = true;

        settings = {
            "org/gnome/shell" = {
                disable-user-extensions = false;
                enabled-extensions = [
                    "blur-my-shell@aunetx"
                    "just-perfection-desktop@just-perfection"
                    "dash-to-dock@micxgx.gmail.com"
                    "clipboard-history@alexsaveau.dev"
                    "rounded-window-corners@fxgn"
                    "user-theme@gnome-shell-extensions.gcampax.github.com"
                    "caffeine@patapon.info"
                    "pip-on-top@rafostar.github.com"
                    "gridgets@rebatnaath.github.com"
                    "azwallpaper@azwallpaper.gitlab.com"
                ];
            };

            "org/gnome/mutter" = {
                dynamic-workspaces = false;
                edge-tiling = true;
            };

            "org/gnome/desktop/wm/preferences" = {
                num-workspaces = 6;
                titlebar-font = "SF Pro Display Bold 11";
            };

            "org/gnome/desktop/wm/keybindings" = {
                switch-to-workspace-1 = [ "<Super>1" ];
                switch-to-workspace-2 = [ "<Super>2" ];
                switch-to-workspace-3 = [ "<Super>3" ];
                switch-to-workspace-4 = [ "<Super>4" ];
                switch-to-workspace-5 = [ "<Super>5" ];
                switch-to-workspace-6 = [ "<Super>6" ];
                move-to-workspace-1 = [ "<Super><Shift>1" ];
                move-to-workspace-2 = [ "<Super><Shift>2" ];
                move-to-workspace-3 = [ "<Super><Shift>3" ];
                move-to-workspace-4 = [ "<Super><Shift>4" ];
                move-to-workspace-5 = [ "<Super><Shift>5" ];
                move-to-workspace-6 = [ "<Super><Shift>6" ];
                close = [ "<Super>q" ];
            };

            "org/gnome/shell/keybindings" = {
                switch-to-application-1 = [];
                switch-to-application-2 = [];
                switch-to-application-3 = [];
                switch-to-application-4 = [];
                switch-to-application-5 = [];
                switch-to-application-6 = [];
                switch-to-application-7 = [];
                switch-to-application-8 = [];
                switch-to-application-9 = [];
            };

            "org/gnome/settings-daemon/plugins/media-keys" = {
                custom-keybindings = [
                    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                ];
            };

            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
                name = "Launch Terminal";
                command = "kgx";
                binding = "<Super>Return";
            };

            "org/gnome/shell/extensions/dash-to-dock" = {
                hot-keys = false;
            };

            "org/gnome/desktop/background" = {
                picture-uri = "file://${config.home.homeDirectory}/nixConfig/assets/walls/paintings/wallhaven-1qp2mw_1920x1080.png";
                picture-uri-dark = "file://${config.home.homeDirectory}/nixConfig/assets/walls/non-category/sand-dune.jpg";
            };
        };
    };
}