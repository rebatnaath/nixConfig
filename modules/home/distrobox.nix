{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        distrobox
        xhost  # GUI apps from a container to wayland/x11
    ];

    # mount nixos paths into containers so host tools stay available
    xdg.configFile."distrobox/distrobox.conf".text = ''
        container_manager="podman"
        container_additional_volumes="/nix/store:/nix/store:ro /etc/profiles/per-user:/etc/profiles/per-user:ro /etc/static/profiles/per-user:/etc/static/profiles/per-user:ro"
    '';

    # bare arch container (distrobox assemble create --file .../distrobox.ini)
    xdg.configFile."distrobox/distrobox.ini".text = ''
        [arch]
        image=archlinux:latest
        pull=true
        start_now=false
        init=false
        nvidia=false
        root=false
        entry=true
    '';
}
