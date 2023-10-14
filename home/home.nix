{ pkgs, config, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModules.default
    ./theme
    ./programs/vscode.nix
    ./programs/git.nix
  ];

  colorScheme = nix-colors.colorSchemes.everforest;

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
    tmux
    neovim
    lazygit
    lazydocker
    neofetch
    ranger
    # Apps
    obsidian
    arandr
    inkscape
    deluge
    gimp
    gnome.nautilus
    # vscode
    spotify
    discord
    deluge-gtk
    vlc
    # Programming
    # - Nix
    nil
    # - Python
    python311
    python311Packages.pip
    python311Packages.mypy
    python311Packages.isort
    python311Packages.black
    poetry
    ruff
    # - Rust
    cargo
    rustc
    # - js
    nodejs_20
    # - lua
    lua
    stylua
    lua-language-server
    love
    # - Go
    go
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
  };

  home.stateVersion = "23.05";

  home.file = {
    ".zshenv".source = ./config/.zshenv;
    ".local/bin/tat".source = ./config/tmux/tat;
  };

  home.sessionVariables = rec {
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = "$PATH:${XDG_BIN_HOME}";
  };

  xdg = {
    enable = true;
    userDirs = with config.home; {
      enable = true;
      extraConfig = { XDG_DEV_DIR = "${homeDirectory}/Development"; };
      createDirectories = true;
    };
    configFile = {
      "zsh".source = ./config/zsh;
      "tmux".source = ./config/tmux;
      "nvim".source = ./config/nvim;
      "picom".source = ./config/picom;
      "rofi".source = ./config/rofi;
      "aliases".source = ./config/aliases;
      "awesome".source = ./config/awesome;
    };
  };

}
