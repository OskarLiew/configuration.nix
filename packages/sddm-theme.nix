{ pkgs, ... }:

let
  imgLink = "https://i.ibb.co/vHymspV/everforest-themed-nixos-wallpaper-i-made-which-isnt-literal-v0-y3o84lcin07b1.png";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "sha256-GAbOVmO1sievwNOBZcxfX27j1AULScm260g8eXqwMSs=";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "Kowbell"; # Fork with backgound color option
    repo = "sddm-sugar-dark";
    rev = "9a80f5790ca1f2f661e6e823c012c1aa65596ed7";
    sha256 = "sha256-wLhO0zRseg3pcUapo+/A2jPKXTzl2cxyf445oBINjPo=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
    echo 'PanelColor="#2E383C"' >> $out/theme.conf
    echo 'ThemeColor="#D3C6AA"' >> $out/theme.conf
    echo 'AccentColor="#A7C080"' >> $out/theme.conf
  '';
}
