{ config, pkgs, ... }:

{
    programs.git = {
        enable = true;
        
        # identity and extra settings
        settings = {
            user = {
                name = "rebatnaath";
                email = "78601591+rebatnaath@users.noreply.github.com";
            };

            init = {
                defaultBranch = "main";
            };

            core = {
                editor = "nvim";
            };
        };

        signing = {
            format = "openpgp";
        };
    };

}