{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-23_11.url = "github:nixos/nixpkgs/nixos-23.11"; # Only used to fix broken nvidia-docker
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    awesome = {
      url = "github:awesomeWM/awesome";
      flake = false;
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs-23_11 = import inputs.nixpkgs-23_11 {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs = import nixpkgs {
        inherit system; config.allowUnfree = true;
        overlays = [ (final: prev: { nvidia-docker = pkgs-23_11.nvidia-docker; }) ];
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
