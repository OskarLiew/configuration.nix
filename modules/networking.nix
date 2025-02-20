{ pkgs, ... }:

{
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

  # Enable networking
  networking.networkmanager.enable = true;
  networking.usePredictableInterfaceNames = false;

  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "FiraCode" "Hack" ]; }) ];

}
