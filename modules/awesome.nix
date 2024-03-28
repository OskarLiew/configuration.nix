{ pkgs, ... }:
let
  awesome = pkgs.awesome.overrideAttrs (oa: {
    version = "YcSLqGix3UtJhy6CZdMXTo7oDQpsfhpcsXSFvD5fVC8=";
    src = pkgs.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "YcSLqGix3UtJhy6CZdMXTo7oDQpsfhpcsXSFvD5fVC8=";
      hash = "sha256-zCxghNGk/GsSt2+9JK8eXRySn9pHXaFhrRU3OtFrDoA=";
    };

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
    displayManager = { defaultSession = "none+awesome"; };
    windowManager.awesome = {
      enable = true;
      package = awesome;
      luaModules = with pkgs.luaPackages; [ cjson ];
    };
  };

  environment.systemPackages = with pkgs; [
    picom
    betterlockscreen
    flameshot
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
