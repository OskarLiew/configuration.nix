{ pkgs ? import <nixpkgs> { } }:
let
  NPM_CONFIG_PREFIX = "$HOME/.local";
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs_22
    biome
    pnpm
    typescript
    typescript-language-server
    vite
  ];

  inherit NPM_CONFIG_PREFIX;

  shellHook = ''
    export PATH="${NPM_CONFIG_PREFIX}/bin:$PATH"
  '';
}
