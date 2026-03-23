{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    awesome = {
      url = "github:awesomeWM/awesome";
      flake = false;
    };
    awesomewm-doc = {
      url = "github:kosorin/awesome-code-doc";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ inputs.nur.overlays.default ];
      };
      upkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # Formatter
      formatter.${system} = pkgs.nixfmt-tree;

      # Add custom packages
      packages.${system} = import ./pkgs nixpkgs.legacyPackages.${system};

      # Configure overlays
      overlays = import ./overlays { inherit inputs; };

      # NixOS configs
      nixosConfigurations = import ./nixos {
        inherit
          pkgs
          upkgs
          system
          inputs
          ;
      };

      # Home manager configs
      homeConfigurations = import ./home-manager { inherit pkgs upkgs inputs; };

    };
}
