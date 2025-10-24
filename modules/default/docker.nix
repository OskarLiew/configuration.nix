{ config, lib, pkgs, ... }:

let
  cfg = config.services.xserver.videoDrivers;
in

{
  virtualisation.docker = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    lazydocker
  ];

  # Enable nvidia containers if nvidia is enabled
  # Test with: docker run --rm -it --device=nvidia.com/gpu=all ubuntu:latest nvidia-smi
  hardware.nvidia-container-toolkit.enable = lib.elem "nvidia" cfg;
  virtualisation.docker.daemon.settings.features.cdi = lib.elem "nvidia" cfg;
}
