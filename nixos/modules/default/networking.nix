{ pkgs, ... }:

# If network suddenly stops working it could be because of mullvad-vpn killswitch setting!
{
  networking = {

    # Enable networking
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd.enable = true;
    usePredictableInterfaceNames = false;

    # Firewall configuration
    firewall = {
      allowedUDPPorts = [ 5353 ]; # For device discovery
      allowedUDPPortRanges = [
        {
          from = 27031;
          to = 27036;
        }
        {
          from = 32768;
          to = 61000;
        }
      ]; # For Streaming
      allowedTCPPorts = [ 8010 ]; # For gnomecast server
      allowedTCPPortRanges = [
        {
          from = 27036;
          to = 27037;
        }
      ];
    };

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;
    twingate.enable = true;

    # VPN
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };

  environment.systemPackages = with pkgs; [
    wirelesstools
    iw
    impala
  ];

}
