{ pkgs, ... }:
{

  home.packages = with pkgs; [
    (writeShellScriptBin "nix-search" ''
       nix search nixpkgs "$1" --json | \
      ${jq}/bin/jq -r 'to_entries[] | "\((.key | split(".")[2:] | join("."))): \(.value.description)"' | \
      ${fzf}/bin/fzf
    '')
  ];
}
