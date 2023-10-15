{ config, pkgs, home-manager, nix-colors, dotfiles, ... }:
let user = "oskar";
in {

  imports = [ ../modules/awesome.nix ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Oskar Liew";
    extraGroups = [ "networkmanager" "wheel" "${user}" "docker" "video" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    users.${user} = import ../home/home.nix;
    extraSpecialArgs = { inherit nix-colors dotfiles; };
  };

  # Services
  services = {
    syncthing = {
      enable = true;
      inherit user;
      dataDir =
        "/home/${user}/Documents"; # Default folder for new synced folders
      configDir =
        "/home/${user}/.config/syncthing"; # Folder for Syncthing's settings and keys
      folders = {
        "Default Folder" = {
          id = "default";
          path = "/home/${user}/Documents/sync";
        };
      };
    };
  };
}

