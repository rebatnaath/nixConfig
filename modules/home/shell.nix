{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        blesh
    ];

    home.sessionVariables = {
        ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
    };

    home.sessionPath = [
        "$HOME/.local/bin"
        "${config.home.homeDirectory}/Android/Sdk/platform-tools"
        "${config.home.homeDirectory}/Android/Sdk/emulator"
    ];

    programs.bash = {
        enable = true;

        shellAliases = {
            ls = "eza --icons -lah";
        };

        # nix wrapper function + ble.sh
        bashrcExtra = ''
            # show fastfetch once per terminal startup
            command -v fastfetch >/dev/null 2>&1 && fastfetch

            # custom nix command (update/rebuild/clean)
            nix() {
                case "$1" in
                    update)
                        echo -e "Updating flake and rebuilding from ~/nixConfig...\n"
                        cd "${config.home.homeDirectory}/nixConfig" && sudo nix flake update && sudo nixos-rebuild switch --flake .#nixos
                        ;;
                    rebuild)
                        echo -e "Rebuilding system from ~/nixConfig...\n"
                        sudo nixos-rebuild switch --flake "${config.home.homeDirectory}/nixConfig#nixos"
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

            # attach ble.sh in interactive sessions
            [[ $- == *i* ]] && source -- "$(blesh-share)"/ble.sh --attach=none
            [[ ! ''${BLE_VERSION-} ]] || ble-attach

            # gpg_tty for pass/pinentry
            export GPG_TTY="$(tty)"
        '';
    };

    # enable starship prompt
    programs.starship = {
        enable = true;
        enableBashIntegration = true;
        settings = builtins.fromTOML (builtins.readFile ./starship-nerd-font-symbols.toml);
    };
}