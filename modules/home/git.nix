{ config, pkgs, ... }:

{
    programs.git = {
        enable = true;
        
        # Identity settings
        userName = "oryza";
        userEmail = "example@example.com";

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