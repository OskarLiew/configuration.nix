{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.nixbtw = nixpkgs.lib.nixosSystem {
        inherit pkgs system;
        specialArgs = { inherit inputs; };
        modules = [
          ./machines/nixbtw/configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x280
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
