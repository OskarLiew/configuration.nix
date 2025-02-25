{ pkgs, upkgs, inputs, ... }:

let
  extraSpecialArgs = { inherit inputs upkgs; };
in

with inputs; {
  "oskar" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs extraSpecialArgs;
    modules = [
      ./home.nix
      ./graphical.nix
      ./programs/syncthing.nix
    ];
  };

  # Generic linux, with graphical interface
  "oskar-generic" =
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs extraSpecialArgs;
      modules = [
        ./home.nix
        ./graphical.nix
        ./packages/awesome.nix
        ./programs/syncthing.nix
        { targets.genericLinux.enable = true; }
      ];
    };

  # Generic linux, without graphical applications
  "oskar-generic-term" =
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs extraSpecialArgs;
      modules = [ ./home.nix { targets.genericLinux.enable = true; } ];
    };
}

