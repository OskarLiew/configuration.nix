{ upkgs, pkgs, inputs, ... }:
let
  awesome = pkgs.awesome.overrideAttrs (oa: {
    version = "YcSLqGix3UtJhy6CZdMXTo7oDQpsfhpcsXSFvD5fVC8=";
    src = inputs.awesome;

    patches = [ ];

    postPatch = ''
      patchShebangs tests/examples/_postprocess.lua
    '';
  });
in
{
  imports = [ ./X11.nix ];

  nixpkgs.overlays = [

    (self: super: { awesome = super.awesome.override { gtk3Support = true; }; })

    (import (fetchGit {
      url = "https://github.com/stefano-m/nix-stefano-m-nix-overlays.git";
      rev = "0c0342bfb795c7fa70e2b760fb576a5f6f26dfff"; # git revision heere
    }))

  ];

  services.xserver = {
    enable = true;
    windowManager.awesome = {
      enable = true;
      package = awesome;
      luaModules = with pkgs.luaPackages; [ cjson ];
    };
  };
  services.displayManager.defaultSession = "none+awesome";

  environment.systemPackages = with pkgs; [
    upkgs.picom
    upkgs.betterlockscreen
    upkgs.flameshot
    rofi
    lm_sensors
    playerctl
  ];

  services.autorandr = {
    hooks.postswitch = {
      "reload-awesome" = ''echo 'awesome.restart()' | awesome-client'';
    };
  };

}
