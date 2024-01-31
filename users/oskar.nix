{ pkgs, ... }:
let user = "oskar";
in {

  imports = [ ../modules/awesome.nix ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Oskar Liew";
    extraGroups = [ "networkmanager" "wheel" "${user}" "docker" "video" "audio" ];
    shell = pkgs.zsh;
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
      settings.folders = {
        "Default Folder" = {
          id = "default";
          path = "/home/${user}/Documents/sync";
        };
      };
    };
  };
}

