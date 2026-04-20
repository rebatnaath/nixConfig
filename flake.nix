{
    description = "My NixOS config";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        zen-browser.url = "github:0xc000022070/zen-browser-flake";
        antigravity-nix.url = "github:jacopone/antigravity-nix";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
        system = "x86_64-linux";
    in
    {
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                inherit system;

                specialArgs = { 
                    inherit inputs system;
                }; 

                modules = [
                    ./hosts/nixos/configuration.nix

                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;

                        home-manager.extraSpecialArgs = {
                            inherit inputs system;
                        };

                        home-manager.users.oryza = import ./hosts/nixos/home.nix;
                    }
                ];
            };
        };
    };
}