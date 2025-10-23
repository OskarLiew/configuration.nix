{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Utils
    path-of-building
    bolt-launcher # OSRS launcher for linux
    osu-lazer-bin
  ];
}
