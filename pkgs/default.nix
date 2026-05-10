pkgs: {
  custom = {
    awakened-poe-trade = pkgs.callPackage ./awakened-poe-trade.nix { };
    osu = pkgs.callPackage ./osu.nix { };
    filebot = pkgs.callPackage ./filebot.nix { };
  };
}
