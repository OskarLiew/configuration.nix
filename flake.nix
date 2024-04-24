{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    awesome = {
        url = "github:awesomeWM/awesome";
        flake = false;
    };
  };

  outputs = { nixpkgs, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      # Machines
      nixosConfigurations.nixbtw = nixpkgs.lib.nixosSystem {
        inherit pkgs system;
        modules = [
          ./machines/nixbtw/configuration.nix
          ./users/oskar.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x280
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
