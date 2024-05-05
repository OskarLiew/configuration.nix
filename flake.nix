{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    awesome = {
      url = "github:awesomeWM/awesome";
      flake = false;
    };
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      # Machines
      nixosConfigurations = {
        nixbtw = nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [
            ./machines/nixbtw
          ];
          specialArgs = { inherit inputs; };
        };
        hopfield = nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [
            ./machines/hopfield
          ];
          specialArgs = { inherit inputs; };
        };

      };
    };
}
