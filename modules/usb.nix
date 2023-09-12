{ pkgs, ... }: {
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];

  environment.systemPackages = with pkgs; [ udiskie ];
}
