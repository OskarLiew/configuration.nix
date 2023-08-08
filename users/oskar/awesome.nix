{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager.defaultSession = "none+awesome";
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [ luarocks luadbi-mysql ];
    };
  };

  services.picom = {
    enable = true;
    vSync = true;
  };

}
