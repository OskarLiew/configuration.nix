{
  pkgs ? import <nixpkgs> { },
}:
(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs =
    pkgs:
    (with pkgs; [
      python314
      python314Packages.pip
      python314Packages.virtualenv
      mypy
      ruff
      pyright
      # cudaPackages.cudatoolkit
    ]);
  runScript = "bash --init-file /etc/profile";
}).env
