{ inputs, ... }:
# Upcoming :)
{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.???

    # Modules
    ../../modules

    # Users
    ../../users/oskar.nix
  ];

  networking.hostName = "hopfield";

  console.keyMap = "sv-latin1";
}
