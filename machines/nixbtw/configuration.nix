{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Modules
    ../../modules/bluetooth.nix
    ../../modules/environment.nix
    ../../modules/localization.nix
    ../../modules/powermanagement.nix
    ../../modules/programs.nix
    ../../modules/sound.nix
    ../../modules/usb.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixbtw"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall = {
    allowedUDPPorts = [ 5353 ]; # For device discovery
    allowedUDPPortRanges = [{
      from = 32768;
      to = 61000;
    }]; # For Streaming
    allowedTCPPorts = [ 8010 ]; # For gnomecast server
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Virtualization
  virtualisation.docker.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.usePredictableInterfaceNames = false;

  # Enable garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "03:15";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Configure console keymap
  console.keyMap = "sv-latin1";

  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "FiraCode" "Hack" ]; }) ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
