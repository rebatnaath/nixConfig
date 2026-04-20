{ config, pkgs, ... }:

{
    programs.git = {
        enable = true;
        
        # Identity settings
        userName = "rebatnaath";
        userEmail = "78601591+rebatnaath@users.noreply.github.com";

        signing = {
            format = "openpgp";
        };

        extraConfig = {
            init = {
                defaultBranch = "main";
            };
            # Optional: helps with large repositories or specific diffing needs
            core = {
                editor = "nvim";
            };
        };
    };

}