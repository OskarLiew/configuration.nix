{ pkgs, ... }:
let
  user = "oskar";
in
{

  imports = [ ../modules/extra/awesome.nix ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Oskar Liew";
    extraGroups = [
      "networkmanager"
      "wheel"
      "${user}"
      "docker"
      "video"
      "audio"
    ];
    shell = pkgs.zsh;
  };
  environment.pathsToLink = [ "/share/zsh" ]; # For completion for system packages
}
