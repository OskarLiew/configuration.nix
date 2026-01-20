{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [
    python313
    uv
    mypy
    ruff
    pyright
  ];
  LD_LIBRARY_PATH =
    with pkgs;
    "${lib.makeLibraryPath [
      stdenv.cc.cc
      libz
    ]}";
  UV_PYTHON_DOWNLOADS = "never";
  shellHook = ''
    echo "Ready!"
  '';
}
