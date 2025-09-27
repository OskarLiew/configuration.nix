{ pkgs, upkgs, inputs, ... }:

let
  extraSpecialArgs = { inherit inputs upkgs; };
in

with inputs; {
  "oskar" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs extraSpecialArgs;
    modules = [
       inputs.stylix.homeModules.stylix
      ./home.nix
      ./modules/desktop.nix
    ];
  };

  # Generic linux, with graphical interface
  "oskar-generic" =
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs extraSpecialArgs;
      modules = [
        inputs.stylix.homeModules.stylix
        ./home.nix
        ./modules/desktop.nix
        ./packages/awesome.nix
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

