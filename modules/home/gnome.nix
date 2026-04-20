{ pkgs, config, ... }:

{
    home.packages = with pkgs; [

        # GNOME Softwares
        gnome-tweaks
        gnome-boxes

        # GNOME Extensions
        gnomeExtensions.blur-my-shell
        gnomeExtensions.just-perfection
        gnomeExtensions.clipboard-history
        gnomeExtensions.dash-to-dock
        gnomeExtensions.rounded-window-corners-reborn
        gnomeExtensions.user-themes
        gnomeExtensions.topicons-plus
        gnomeExtensions.caffeine
        gnomeExtensions.system-monitor
        gnomeExtensions.pip-on-top
    ];

    gtk = {
        enable = true;
        # Silences the GTK4 evaluation warning
        gtk4.theme = null;

        iconTheme = {
            name = "MonoIcons";
        };

        cursorTheme = {
            name = "WhiteSur-cursors";
            size = 24;
        };
    };

 
    # GNOME Desktop Configuration (Dconf)
    dconf = {
        enable = true;

        settings = {
        # Enable GNOME extensions
        "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = [
                "blur-my-shell@aunetx"
                "just-perfection-desktop@just-perfection"
                "dash-to-dock@micxgx.gmail.com"
                "clipboard-history@alexsaveau.dev"
                "rounded-window-corners@fxgn"
                "user-theme@gnome-shell-extensions.gcampax.github.com"
                "topicons-plus@phocean.net"
                "caffeine@patapon.info"
                "system-monitor@gnome-shell-extensions.gcampax.github.com"
            ];
        };

        # Main Interface Settings (Fonts, Icons, Cursors)
        "org/gnome/desktop/interface" = {
            font-name = "SF Pro Display 11";
            document-font-name = "SF Pro Display 11";
            monospace-font-name = "JetBrains Mono 11";
        
            icon-theme = "MonoIcons";
            cursor-theme = "WhiteSur-cursors";

            font-antialiasing = "rgba";
            font-hinting = "full";
        };

        # Workspaces Fixed to 6
        "org/gnome/mutter" = {
            dynamic-workspaces = false;
            edge-tiling = true;
        };

        "org/gnome/desktop/wm/preferences" = {
            num-workspaces = 6;
            titlebar-font = "SF Pro Display Bold 11";
        };

        # Workspace Keybindings (Switching & Moving)
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
        };

        # Conflict Resolution: Disable App Launchers and Dock Hotkeys
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

        "org/gnome/shell/extensions/dash-to-dock" = {
            hot-keys = false;
        };

        # Wallpaper Settings
        "org/gnome/desktop/background" = {
            picture-uri = "file://${config.home.homeDirectory}/nixConfig/assets/walls/light.png";
            picture-uri-dark = "file://${config.home.homeDirectory}/nixConfig/assets/walls/dark.png";
        };
    };
  };
}