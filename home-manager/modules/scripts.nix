{ pkgs, ... }:
{

  home.packages = with pkgs; [
    (writeShellScriptBin "nix-search" ''
      # Search for a package in nixpkgs using nix search, display results in fzf, and open its NixOS search page in Firefox

      result=$(nix search nixpkgs "$1" --json | \
        jq -r 'to_entries[] | "\((.key | split(".")[2:] | join("."))): \(.value.description)"' | \
        fzf)

      # Extract the package name (before the colon)
      pkg_name=$(echo "$result" | cut -d':' -f1 | xargs)

      # If a package was selected, open its NixOS search page
      if [ -n "$pkg_name" ]; then
        firefox "https://search.nixos.org/packages?query=$pkg_name" &
      else
        echo "No package selected."
      fi
    '')
  ];
}
