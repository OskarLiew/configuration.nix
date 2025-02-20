{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    awesome = {
      url = "github:awesomeWM/awesome";
      flake = false;
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system; config.allowUnfree = true;
      };
      upkgs = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
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
          specialArgs = { inherit upkgs inputs; };
        };
        hopfield = nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [
            ./machines/hopfield
          ];
          specialArgs = { inherit upkgs inputs; };
        };

      };
    };
}
