{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awesome = {
      url = "github:awesomeWM/awesome";
      flake = false;
    };
    awesomewm-doc = {
      url = "github:kosorin/awesome-code-doc";
      flake = false;
    };
    stylix.url = "github:nix-community/stylix/release-25.05";
  };

  outputs = { nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system; config.allowUnfree = true;
        overlays = [ inputs.nur.overlays.default ];
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
        static = nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [
            ./machines/static
          ];
          specialArgs = { inherit upkgs inputs; };
        };
      };
      homeConfigurations = import ./home { inherit pkgs upkgs inputs; };
    };
}
