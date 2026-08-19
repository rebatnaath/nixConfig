{ pkgs, ... }:

{
    home.packages = [ pkgs.kitty ];

    # kitty.conf is edited directly at ~/.config/kitty/kitty.conf (not managed here)
}