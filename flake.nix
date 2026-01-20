{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/master";
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
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ inputs.nur.overlays.default ];
      };
    in
    {
      formatter.${system} = pkgs.nixfmt-tree;

      # Machines
      nixosConfigurations = {
        nixbtw = nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [ ./machines/nixbtw ];
          specialArgs = { inherit inputs; };
        };
        static = nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [ ./machines/static ];
          specialArgs = { inherit inputs; };
        };
      };

      # Home manager
      homeConfigurations = import ./home { inherit pkgs inputs; };
    };
}
