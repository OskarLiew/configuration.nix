{ inputs, ... }:

{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x280

    # Modules
    ../modules
    ../modules/extra/gaming.nix
    ../modules/extra/programs.nix

    # Users
    ../users.nix

    # Desktop environment
    ../modules/extra/awesome.nix
  ];

  networking.hostName = "nixbtw";

  nixpkgs.overlays = [
    inputs.self.overlays.additions
    inputs.self.overlays.modifications
  ];
}
