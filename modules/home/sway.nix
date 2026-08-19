{ pkgs, config, ... }:

{
    # sway config lives at ~/.config/sway/config (editable, not home-manager-managed)

    home.packages = with pkgs; [
        swaylock
        swaybg
        wlsunset
        matugen
        imagemagick
        quickshell
        awww
        grim
        slurp
        wl-clipboard
        cliphist
        wireplumber
        brightnessctl
        rofi
        libnotify
        wl-screenrec
    ];
}