{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Utils
    bolt-launcher # OSRS launcher for linux
    osu-lazer-bin
    custom.awakened-poe-trade
    rusty-path-of-building
    (retroarch.withCores (
      cores: with cores; [
        gambatte # GB
        mgba # GBA
        fceumm # NES
        snes9x # SNES
        melonds # Nintendo DS
        parallel-n64 # N64
        dolphin # GC / Wii
        citra # 3DS
      ]
    ))
  ];
}
