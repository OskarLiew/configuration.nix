{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { nixpkgs, nixos-hardware, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.nixbtw = nixpkgs.lib.nixosSystem {
        inherit pkgs system;
        modules = [
          ./machines/nixbtw/configuration.nix
          ./users/oskar.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x280
        ];
      };
    };
}
