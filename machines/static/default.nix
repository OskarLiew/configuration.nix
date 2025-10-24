{ inputs, config, lib, pkgs, ... }:
# Upcoming :)
{
  imports = [
    # Hardware
    ./hardware-configuration.nix

    # Modules
    ../../modules
    ../../modules/extra/gaming.nix
    ../../modules/extra/jellyfin.nix
    ../../modules/extra/audiobookshelf.nix

    # Users
    ../../users/oskar.nix
  ];

  networking.hostName = "static";

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

  # Disks
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/d10bfc31-1841-43e8-a901-13165a7794c7";
    fsType = "ext4";
  };
  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/514bc2bb-9ceb-4207-a0db-c75d329943d4";
    fsType = "ext4";
    options = [ "defaults" "nofail" "users" "exec" ];
  };

}
