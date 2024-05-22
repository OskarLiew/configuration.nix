{ inputs, config, lib, ... }:
# Upcoming :)
{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd

    # Modules
    ../../modules

    # Users
    ../../users/oskar.nix
  ];

  networking.hostName = "hopfield";

  services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelParams = [
    "nvme.noacpi=1"
  ];

  # hardware.opengl = {
  #     enable = true;
  #     driSupport = true;
  #     driSupport32Bit = true;
  # };

  hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # modesetting.enable = true;

      prime = {
          # offload = {
          #     enable = true;
          #     enableOffloadCmd = true;
          # };
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
      };

  };
  #
  # specialisation = {
  #   nvidia-on.configuration = {
  #       hardware.nvidia.prime= {
  #           offload.enable = lib.mkForce false;
  #           offload.enableOffloadCmd = lib.mkForce false;
  #           sync.enable = lib.mkForce true;
  #       };
  #   };
  # };

  console.keyMap = "sv-latin1";
}
