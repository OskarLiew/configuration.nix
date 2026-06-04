{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;
  };

  xdg.configFile = {
    "nvim".source = ../../config/nvim;
  };
}
