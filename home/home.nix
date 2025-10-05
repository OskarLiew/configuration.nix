{ config, ... }: {
  home.username = "oskar";
  home.homeDirectory = "/home/oskar";

  imports = [
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/shell-tools.nix
    ./programs/zsh.nix
    ./programming
    ./theme/shell.nix
  ];


  programs.home-manager.enable = true;

  home.sessionVariables = rec {
    EDITOR = "nvim";
    VISUAL = "nvim";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = "$PATH:${XDG_BIN_HOME}";
  };

  xdg = {
    enable = true;
    userDirs = with config.home; {
      enable = true;
      extraConfig = { XDG_DEV_DIR = "${homeDirectory}/Develop"; };
      createDirectories = true;
      desktop = null;
      publicShare = null;
      templates = null;
    };
    configFile = {
      "aliases".source = ./config/aliases;
    };
  };

  home.stateVersion = "23.05"; # Don't change

}
