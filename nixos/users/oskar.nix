{ pkgs, ... }:
let
  user = "oskar";
  name = "Oskar Liew";
in
{
  imports = [ ../modules/extra/awesome.nix ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = name;
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
