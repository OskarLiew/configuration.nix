let
  user = "caroline";
  name = "Caroline Liew";
in
{
  imports = [ ../modules/extra/plasma.nix ];

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
  };
}
