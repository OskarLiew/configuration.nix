{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    arandr # Screen config util
  ];

  environment.shellAliases = {
    o = "xdg-open";
  };

  # Automatic configuration of screens
  services.autorandr.enable = true;

  # Screen-lock
  programs.i3lock.enable = true;

  hardware.acpilight.enable = true;
}
