{ inputs, config, lib, pkgs, ... }:
# Upcoming :)
{
  imports = [
    # Hardware
    ./hardware-configuration.nix

    # Modules
    ../../modules
    ../../modules/gaming.nix

    # Users
    ../../users/oskar.nix
  ];

  networking.hostName = "desktop";

  services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelParams = [
    "nvme.noacpi=1"
    "usbcore.autosuspend=-1"
  ];

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false;

    modesetting.enable = true;

  };

  # Enable nvidia containers
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.daemon.settings.features.cdi = true;
  virtualisation.docker.enableNvidia = true;

  console.keyMap = "sv-latin1";
}
