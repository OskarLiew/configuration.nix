pkgs: {
  custom = {
    awakened-poe-trade = pkgs.callPackage ./awakened-poe-trade.nix { };
    filebot = pkgs.callPackage ./filebot.nix { };
  };
}
