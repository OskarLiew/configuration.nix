{ inputs, ... }:

{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x280

    # Modules
    ../../modules
    ../../modules/gaming.nix

    # Users
    ../../users/oskar.nix
  ];

  networking.hostName = "nixbtw";

  console.keyMap = "sv-latin1";
}
