{
  description = "My nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  # add the inputs declared above to the argument attribute set
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      darwin,
    }:
    {
      darwinConfigurations."Deimos" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          ./hosts/Deimos/default.nix
        ];
      };

      darwinConfigurations."Europa" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          unstablePkgs = nixpkgs-unstable.legacyPackages.aarch64-darwin;
        };
        modules = [
          home-manager.darwinModules.home-manager
          ./hosts/Europa/default.nix
        ];
      };

      darwinConfigurations."Phobos" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          unstablePkgs = nixpkgs-unstable.legacyPackages.aarch64-darwin;
        };
        modules = [
          home-manager.darwinModules.home-manager
          ./hosts/Phobos/default.nix
        ];
      };
    };
}
