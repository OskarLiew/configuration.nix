{
  pkgs,
  version ? "2.57.0",
  ...
}:
let
  data = pkgs.stdenv.mkDerivation (finalAttrs: {
    pname = "path-of-building-data";
    version = "${version}-custom";

    src = pkgs.fetchFromGitHub {
      owner = "PathOfBuildingCommunity";
      repo = "PathOfBuilding";
      tag = "v${version}";
      hash = "sha256-JL8L3zKz5najr4g/Mev3tOe+C/LntOxwx/5bPErIw7g=";
    };

    nativeBuildInputs = [ pkgs.unzip ];

    buildCommand = ''
      # I have absolutely no idea how this file is generated
      # and I don't think I want to know. The Flatpak also does this.
      unzip -j -d $out $src/runtime-win32.zip lua/sha1.lua

      # Install the actual data
      cp -r $src/src $src/runtime/lua/*.lua $src/manifest.xml $out

      # Pretend this is an official build so we don't get the ugly "dev mode" warning
      substituteInPlace $out/manifest.xml --replace '<Version' '<Version platform="nixos"'
      touch $out/installed.cfg

      # Completely stub out the update check
      chmod +w $out/src/UpdateCheck.lua
      echo 'return "none"' > $out/src/UpdateCheck.lua
    '';
  });
in
pkgs.stdenv.mkDerivation {
  pname = "path-of-building";
  version = "${data.version}-frontend";

  src = pkgs.fetchFromGitHub {
    owner = "ernstp";
    repo = "pobfrontend";
    rev = "7e09fdc29d1e72e9122db71e41ba03fd54bf428b"; # You may need to update this
    hash = "sha256-ka/P83zznuH9dMFKBNt4yVNffPcMy2amr4GMgTVa/Lc=";
  };

  nativeBuildInputs =
    with pkgs;
    [
      meson
      ninja
      pkg-config
      kdePackages.qttools
      kdePackages.wrapQtAppsHook
      icoutils
    ]
    ++ lib.optional stdenv.hostPlatform.isLinux copyDesktopItems;

  buildInputs = with pkgs; [
    kdePackages.qtbase
    luajit
    luajit.pkgs.lua-curl
    luajit.pkgs.luautf8
  ];

  installPhase = ''
    runHook preInstall
    install -Dm555 pobfrontend $out/bin/pobfrontend

    wrestool -x -t 14 ${data.src}/runtime/Path{space}of{space}Building.exe -o pathofbuilding.ico
    icotool -x pathofbuilding.ico

    for size in 16 32 48 256; do
      mkdir -p $out/share/icons/hicolor/"$size"x"$size"/apps
      install -Dm 644 pathofbuilding*"$size"x"$size"*.png \
        $out/share/icons/hicolor/"$size"x"$size"/apps/pathofbuilding.png
    done
    rm pathofbuilding.ico

    runHook postInstall
  '';

  preFixup = ''
    qtWrapperArgs+=(
      --set LUA_PATH "$LUA_PATH"
      --set LUA_CPATH "$LUA_CPATH"
      --chdir "${data}"
    )
  '';

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "path-of-building";
      desktopName = "Path of Building";
      comment = "Offline build planner for Path of Exile";
      exec = "pobfrontend %U";
      terminal = false;
      type = "Application";
      icon = "pathofbuilding";
      categories = [ "Game" ];
      keywords = [
        "poe"
        "pob"
        "pobc"
        "path"
        "exile"
      ];
      mimeTypes = [ "x-scheme-handler/pob" ];
    })
  ];

  passthru.data = data;

  meta = {
    description = "Offline build planner for Path of Exile";
    homepage = "https://pathofbuilding.community/";
    license = pkgs.lib.licenses.mit;
    maintainers = [ pkgs.lib.maintainers.k900 ];
    mainProgram = "pobfrontend";
    broken = pkgs.stdenv.hostPlatform.isDarwin; # doesn't find uic6 for some reason
  };
}
