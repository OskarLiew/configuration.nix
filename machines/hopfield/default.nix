{ inputs, config, lib, pkgs, ... }:
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
    ../../modules/gaming

    # Users
    ../../users/oskar.nix
  ];

  networking.hostName = "hopfield";

  services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelParams = [
    "nvme.noacpi=1"
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  environment.systemPackages = [
    (
      pkgs.writeShellScriptBin "gpu" ''
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
        exec "$@"
      ''
    )
  ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    modesetting.enable = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };

  specialisation = {
    nvidia-on.configuration = {
      hardware.nvidia.prime = {
        offload.enable = lib.mkForce false;
        offload.enableOffloadCmd = lib.mkForce false;
        sync.enable = lib.mkForce true;
      };
      services.xserver.videoDrivers = lib.mkForce [ "nvidia" ];
    };
  };

  console.keyMap = "sv-latin1";
}
