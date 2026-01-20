{
  config,
  inputs,
  ...
}:
{
  imports = [
    ./modules/programs/git.nix
    ./modules/programs/neovim.nix
    ./modules/programs/shell-tools.nix
    ./modules/programs/zsh.nix
    ./modules/programming
    ./modules/theme/shell.nix
    ./modules/workmode.nix
    ./modules/scripts.nix
  ];

  nixpkgs.overlays = [
    inputs.self.overlays.additions
    inputs.self.overlays.modifications
  ];

  programs.home-manager.enable = true;

  home.username = "oskar";
  home.homeDirectory = "/home/oskar";

  xdg = {
    enable = true;
    userDirs = with config.home; {
      enable = true;
      extraConfig = {
        XDG_DEV_DIR = "${homeDirectory}/Develop";
      };
      createDirectories = true;
      desktop = null;
      publicShare = null;
    };
    configFile = {
      "aliases".source = ./config/aliases;
    };
  };

  home.stateVersion = "23.05"; # Don't change

}
