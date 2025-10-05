{ inputs, config, lib, pkgs, ... }:
# Upcoming :)
{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    # inputs.nixos-hardware.nixosModules.common-cpu-intel
    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    # inputs.nixos-hardware.nixosModules.common-pc-laptop
    # inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd

    # Modules
    ../../modules
    ../../modules/gaming.nix

    # Users
    ../../users/oskar.nix
  ];

  networking.hostName = "hopfield";

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
