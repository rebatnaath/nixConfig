{ config, pkgs, ... }:

{
    programs.bash = {
        enable = true;
        shellAliases = {
            ls = "eza --icons -lah";
        };

        initExtra = ''
            # Run fastfetch on startup
            fastfetch

            # Custom Nix Wrapper Function
            nix() {
                case "$1" in
                    update)
                        echo -e "Updating flake and rebuilding from ~/nixConfig...\n"
                        cd ${config.home.homeDirectory}/nixConfig && sudo nix flake update && sudo nixos-rebuild switch --flake .#nixos
                        ;;

                    rebuild)
                        echo -e "Rebuilding system from ~/nixConfig...\n"
                        sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixConfig#nixos
                        ;;
          
                    clean)
                        echo -e "Cleaning old generations (keeping last 3)...\n"
                        sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3
                        nix-env --delete-generations +3
                        sudo nix-collect-garbage -d
                        ;;

                    *)
                        command nix "$@"
                        ;;
                esac
            }
        '';
    };
}