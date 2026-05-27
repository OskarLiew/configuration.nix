{ pkgs, lib, ... }:
{
  services = {
    desktopManager.plasma6.enable = true;
    power-profiles-daemon.enable = lib.mkForce false; # Prefer tlp from powermanagement
  };

  environment.systemPackages = with pkgs; [
    # KDE Utilities
    kdePackages.discover # Optional: Software center for Flatpaks/firmware updates
    kdePackages.kcalc # Calculator
    kdePackages.kcharselect # Character map
    kdePackages.kclock # Clock app

    # Hardware/System Utilities (Optional)
    hardinfo2 # System benchmarks and hardware info
    wayland-utils # Wayland diagnostic tools
    wl-clipboard # Wayland copy/paste support
  ];
}
