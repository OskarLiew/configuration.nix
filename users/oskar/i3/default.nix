
{ config, pkgs, callPackage, ... }: 

{
  imports = [
    ../../../modules/X11.nix
  ];

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };
   
    displayManager = {
        defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status # gives you the default i3 status bar
        feh # Wallpapers
        betterlockscreen
        picom
        rofi
     ];
     extraConfig = builtins.readFile ./config;
    };
  };

}
