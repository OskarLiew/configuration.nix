{ pkgs }:
let
  version = "3.27.106";
  pname = "awakened-poe-trade";
  description = "💲 🔨 Path of Exile trading app for price checking";
  desktopItem = (
    pkgs.makeDesktopItem {
      name = "AwakenedPoETrade";
      exec = "${pname}";
      icon = "${pkgs.fetchurl {
        url = "https://camo.githubusercontent.com/7f1a684d23f3b5bce8746fbe13c99d87a5cb01176de29d6073480adc276e6e18/68747470733a2f2f7765622e706f6563646e2e636f6d2f696d6167652f4172742f32444974656d732f43757272656e63792f5472616e736665724f72622e706e67";
        sha256 = "sha256-USAblgANZUXJHzTB6JTpMHNwkgTvgRtUvUklxCH/Tl4=";
      }}";
      comment = "${description}";
      desktopName = "Awakened PoE Trade";
      keywords = [
        "poe"
        "path"
        "exile"
      ];
    }
  );
in
pkgs.appimageTools.wrapType2 {
  pname = "awakened-poe-trade";
  version = "${version}";
  src = pkgs.fetchurl {
    url = "https://github.com/SnosMe/awakened-poe-trade/releases/download/v${version}/Awakened-PoE-Trade-${version}.AppImage";
    hash = "sha256-8L5Szn0KYfUMaTe+yyhJV1YZspmJCSlXSHXLPoiRhjE=";
  };

  extraInstallCommands = ''
    mkdir "$out/share"
    ln -s "${desktopItem}/share/applications" "$out/share/"
  '';

  meta = {
    homepage = "https://github.com/SnosMe/awakened-poe-trade";
    description = "${description}";
    platforms = pkgs.lib.platforms.linux;
  };
}
