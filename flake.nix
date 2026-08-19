{
    description = "My NixOS config";

    inputs = {
        # Pinned to a known-good nixpkgs (2026-08-10). Unstable snapshots after
        # this (e.g. 0e251e) break jetbrains-mono/nanoemoji with a stale source
        # hash. `nix flake update` will still update the other inputs but not
        # nixpkgs until this rev is bumped manually.
        nixpkgs.url = "github:NixOS/nixpkgs/2fcb964de67fcf60b43471c55d5d99e61a9ccb5a";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        zen-browser.url = "github:0xc000022070/zen-browser-flake";
        # antigravity-nix.url = "github:jacopone/antigravity-nix";
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
                    }
                ];
            };
        };
    };
}