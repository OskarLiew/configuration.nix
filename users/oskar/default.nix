{ config, pkgs, home-manager, ... }:
let user = "oskar";
in {
  imports = [ ./awesome.nix ];
  # GUI

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Oskar Liew";
    extraGroups = [ "networkmanager" "wheel" "${user}" ];
    shell = pkgs.zsh;
  };

  home-manager.users.${user} = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      # Shell
      pure-prompt
      zsh-autocomplete
      zsh-autosuggestions
      bat
      fzf
      ripgrep
      # TUI apps
      neovim
      lazygit
      neofetch
      ranger
      # Apps
      rofi
      obsidian
      # Programming
      python312
      poetry
      cargo
      rustc
    ];

    programs = {
      firefox.enable = true;
      kitty = {
        enable = true;
        theme = "One Dark";
      };
      git = {
        enable = true;
        userName = "Oskar Liew";
        userEmail = "oskar@liew.se";
      };
    };

    home.stateVersion = "23.05";
  };

  # Services

  services = {
    syncthing = {
      enable = true;
      inherit user;
      dataDir = "/home/${user}/docs"; # Default folder for new synced folders
      configDir =
        "/home/${user}/.config/syncthing"; # Folder for Syncthing's settings and keys
      folders = {
        "Default Folder" = {
          id = "default";
          path = "/home/${user}/docs/sync";
        };
      };
    };
  };

}
