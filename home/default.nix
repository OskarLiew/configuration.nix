{ config, pkgs, home-manager, nix-colors, ... }:
let user = "oskar";
in {

  imports = [ ../modules/awesome.nix ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    histSize = 10000;
    histFile = "$XDG_CACHE_HOME/zsh/.zsh_history";
    setOptions = [ ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Oskar Liew";
    extraGroups = [ "networkmanager" "wheel" "${user}" "docker" "video" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    users.${user} = import ./home.nix;
    extraSpecialArgs = { inherit nix-colors; };
  };

  # Services
  services = {
    gvfs.enable = true;
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

