{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Utils
    bolt-launcher # OSRS launcher for linux
    osu-lazer-bin
    # (pkgs.callPackage ../packages/path-of-building.nix { version = "2.57.0"; })
    # (pkgs.callPackage ../packages/awakened-poe-trade.nix { ver = "3.27.101"; })
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
