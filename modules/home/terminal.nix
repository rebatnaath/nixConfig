{ pkgs, ... }:

{
    # terminal gui and tui plugins
    home.packages = with pkgs; [
        # custom packages (not yet in nixpkgs)
        (pkgs.callPackage ../../packages/csakura.nix { })

        # file manager + viewers (yazi itself is installed via programs.yazi below)
        imv                     # image viewer (wayland + x11)
        zathura                 # pdf / document viewer

        # system / monitors
        btop                    # system monitor
        cava                    # audio visualizer
        cmatrix                 # matrix rain
        pipes                   # animated pipes screensaver

        # render stuff in the terminal
        chafa                   # images -> ascii/sixel/kitty
        glow                    # render markdown files
        jp2a                    # images -> ascii art

        # git tui
        lazygit
    ];

    # yazi terminal file manager
    programs.yazi = {
        enable = true;

        # `y` wrapper: cd into the directory yazi left you in on exit
        shellWrapperName = "y";
        enableBashIntegration = true;
        enableFishIntegration = true;

        # use our image/pdf viewers when opening files
        settings = {
            opener = {
                imv = [
                    {
                        run = "imv %s1";
                        desc = "Open with imv";
                        block = true;
                        for = "linux";
                    }
                ];
                zathura = [
                    {
                        run = "zathura %s1";
                        desc = "Open PDF with zathura";
                        block = true;
                        for = "linux";
                    }
                ];
            };

            open.prepend_rules = [
                { mime = "image/*"; use = [ "imv" "open" "reveal" ]; }
                { mime = "application/pdf"; use = [ "zathura" "open" "reveal" ]; }
            ];
        };

        # structural styling only; inherit terminal palette
        theme = {
            mgr = {
                find_keyword = { bold = true; italic = true; underline = true; };
                find_position = { bold = true; italic = true; };
                symlink_target = { italic = true; };
                marker_symbol = "│";
                border_symbol = "│";
            };

            # solid rectangle highlight on the hovered file
            indicator = {
                parent = { reversed = true; };
                current = { reversed = true; };
                preview = { underline = true; };
                padding = { open = ""; close = ""; };
            };

            tabs = {
                active = { bold = true; };
                sep_inner = { open = ""; close = ""; };
                sep_outer = { open = ""; close = ""; };
            };

            mode = {
                normal_main = { bold = true; };
                select_main = { bold = true; };
                unset_main = { bold = true; };
            };

            status = {
                sep_left = { open = ""; close = ""; };
                sep_right = { open = ""; close = ""; };
                progress_label = { bold = true; };
            };

            which = {
                cols = 3;
                separator = " 󰁔 ";
            };

            confirm = {
                btn_yes = { bold = true; };
                btn_labels = [ " [Y]es " " (N)o " ];
            };

            notify = {
                icon_info = "";
                icon_warn = "";
                icon_error = "";
            };

            pick = {
                active = { bold = true; };
            };

            input = {
                selected = { reversed = true; };
            };

            cmp = {
                active = { reversed = true; };
                icon_file = "";
                icon_folder = "";
                icon_command = "";
            };

            tasks = {
                hovered = { bold = true; };
            };

            help = {
                hovered = { reversed = true; bold = true; };
                icon_info = "";
                icon_warn = "";
                icon_error = "";
            };
        };
    };

    # show the current file path in an overlay bar
    xdg.configFile."imv/config".text = ''
        [options]
        overlay = true
        overlay_position_bottom = true
        overlay_text = "$imv_current_file ($imv_current_index/$imv_file_count)"
        overlay_font = GeistMono:7
        overlay_text_color = 000000
        overlay_text_alpha = ff
        overlay_background_color = ffffff
        overlay_background_alpha = ff
    '';
}
