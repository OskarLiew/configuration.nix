{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.caddy = {
    enable = true;
    virtualHosts."jellyfin.oskarliew.com".extraConfig = ''
      reverse_proxy 127.0.0.1:8096
    '';
  };
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
