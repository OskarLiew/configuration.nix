{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bolt-launcher # osrs
    (pkgs.osu-lazer-bin.overrideAttrs (oa: rec {
      # pname = "osu";
      version = "2026.406.0";
      src = (
        fetchurl {
          url = "https://github.com/ppy/osu/releases/download/${version}-lazer/osu.AppImage";
          hash = "sha256-RKKhf193BYF7dYL1x4gF2+Kl2xHuWZ/WMYBk4M/x8S0=";
        }
      );
    }))
    custom.awakened-poe-trade
    rusty-path-of-building
    (retroarch.withCores (
      cores: with cores; [
        gambatte
        mgba
        fceumm
        snes9x
        melonds
        parallel-n64
        dolphin
        citra
      ]
    ))
  ];
}
