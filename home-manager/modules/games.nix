{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bolt-launcher # osrs
    custom.osu
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
