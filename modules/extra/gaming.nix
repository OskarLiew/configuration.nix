{ pkgs, ... }:

{
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  # Proton GE
  # Greatly improves performance on some titles. Must be installed imperatively
  # Run protonup -d ~/.steam/root/compatibilitytools.d && protonup
  # Then enable in steam game options under compatibility
  environment.systemPackages = with pkgs; [ protonup ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  # Gamemode can improve performace on some titles. Add gamemoderun %command% to steam options
  programs.gamemode.enable = true;

}
