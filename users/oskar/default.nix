{ config, pkgs, home-manager, ... }:
let user = "oskar";
in {
  imports = [ ./awesome ];

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

  home-manager.users.${user} = { pkgs, ... }: {
    imports = [ ./theme.nix ];

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      # Shell
      bat
      fzf
      ripgrep
      tree
      parallel
      tldr
      # TUI apps
      neovim
      lazygit
      lazydocker
      neofetch
      ranger
      # Apps
      obsidian
      arandr
      inkscape
      gimp
      gnome.nautilus
      vscode
      spotify
      discord
      # Programming
      python312
      poetry
      cargo
      rustc
      nodejs_20
      lua
      # Misc
      dconf
      mpd
    ];

    programs = {
      firefox.enable = true;
      kitty = {
        enable = true;
        theme = "Everforest Dark Hard";
        settings = { confirm_os_window_close = 2; };
      };
      git = {
        enable = true;
        userName = "Oskar Liew";
        userEmail = "oskar@liew.se";
      };
    };

    home.stateVersion = "23.05";

    home.file = {
      ".config/zsh".source = ./config/zsh;
      ".zshenv".source = ./config/.zshenv;
      ".config/tmux".source = ./config/tmux;
      ".local/bin/tat".source = ./config/tmux/tat;
      ".config/nvim".source = ./config/nvim;
      ".config/picom".source = ./config/picom;
      ".config/rofi".source = ./config/rofi;
      ".config/aliases".source = ./config/aliases;
      ".config/awesome".source = ./awesome/awesomerc;
    };

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

