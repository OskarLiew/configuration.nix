{ pkgs, ... }: {
  services.devmon.enable = true;
  services.gvfs.enable = true;

  services.udisks2.enable = true;
  services.udisks2.mountOnMedia = true;

  boot.supportedFilesystems = [ "ntfs" ];

  environment.systemPackages = with pkgs; [ udiskie ];
}
