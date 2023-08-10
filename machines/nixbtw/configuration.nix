# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Users
    ../../users/oskar

    # Modules
    ../../modules/localization.nix
    ../../modules/environment.nix
    ../../modules/bluetooth.nix
    ../../modules/sound.nix
    ../../modules/powermanagement.nix
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

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "03:15";

# Enable CUPS to print documents.
  services.printing.enable = true;

  services.xserver.displayManager = { sddm.enable = true; };

  # Configure keymap in X11
  services.xserver = {
    layout = "se,us";
    xkbVariant = "";
    xkbOptions = "grp:rctrl_rshift_toggle";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;

    touchpad = {
      naturalScrolling = true;
      accelProfile = "flat";
      accelSpeed = "0.7";
    };
  };

  fonts.fonts = with pkgs;
    [ (nerdfonts.override { fonts = [ "FiraCode" "Hack" ]; }) ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    tmux
    git
    wget
    python38
    lua
    gcc
    gnumake
    cmake
    chromium
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Virtualization
  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
