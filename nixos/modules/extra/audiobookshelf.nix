let
  port = 8097;
in
{
  services.audiobookshelf = {
    enable = true;
    host = "0.0.0.0";
    port = port;
    openFirewall = true;
  };

  services.caddy = {
    enable = true;
    virtualHosts."audiobookshelf.oskarliew.com".extraConfig = ''
      reverse_proxy 127.0.0.1:${builtins.toString port}
    '';
  };
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
