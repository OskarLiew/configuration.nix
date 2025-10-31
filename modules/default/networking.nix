{ pkgs, ... }:

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
          from = 32768;
          to = 61000;
        }
      ]; # For Streaming
      allowedTCPPorts = [ 8010 ]; # For gnomecast server
    };

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;

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
