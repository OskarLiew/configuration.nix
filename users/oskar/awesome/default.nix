{ pkgs, ... }:
let
  awesome = pkgs.awesome.overrideAttrs (oa: {
    version = "d36e1324d17efd571cec252374a2ef5f1eeae4fd";
    src = pkgs.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "d36e1324d17efd571cec252374a2ef5f1eeae4fd";
      hash = "sha256-zCxghNGk/GsSt2+9JK8eXRySn9pHXaFhrRU3OtFrDoA=";
    };

    patches = [ ];

    postPatch = ''
      patchShebangs tests/examples/_postprocess.lua
    '';
  });
in {
  imports = [ ../../../modules/X11.nix ];

  services.xserver = {
    enable = true;
    displayManager = { defaultSession = "none+awesome"; };
    windowManager.awesome = {
      enable = true;
      package = awesome;
    };
  };

  environment.systemPackages = with pkgs; [ picom rofi ];
}