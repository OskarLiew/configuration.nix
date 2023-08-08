
{ config, pkgs, ... }:

{
  imports =
    [ <home-manager/nixos> ];
 
  # GUI

  services.xserver = {
    enable = true;

    displayManager.defaultSession = "none+awesome";
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
	    luadbi-mysql
      ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.oskar = {
    isNormalUser = true;
    description = "Oskar Liew";
    extraGroups = [ "networkmanager" "wheel" "oskar"];
    shell = pkgs.zsh;
  };

  home-manager.users.oskar = { pkgs, ... }: {
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
      # Apps
      kitty
      rofi
      # Programming
      python312
    ];
    home.stateVersion = "23.05";
  };

  services.picom = {
    enable = true;
    vSync = true;
  };
}
