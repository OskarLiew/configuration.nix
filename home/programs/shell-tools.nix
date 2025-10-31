{ pkgs, upkgs, ... }:
{
  home.packages = with pkgs; [
    tldr

    # TUI apps
    russ
  ];

  xdg.configFile = {
    "tmux".source = ../config/tmux;
    "fd".source = ../config/fd;
  };
  home.file = {
    ".local/bin/tat".source = ../config/tmux/tat;
  };

  programs = {
    btop = {
      enable = true;
      package = upkgs.btop;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  services = {
    ssh-agent.enable = true;
  };
}
