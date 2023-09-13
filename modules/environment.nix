{ config, pkgs, ... }:

{
  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    # Not officially in the spec
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [ "${XDG_BIN_HOME}" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    tmux
    git
    wget
    python38
    python38Packages.pip
    lua
    gcc
    gnumake
    cmake
    pciutils
    chromium
    pulseaudio
    acpilight
    playerctl
    procps
    upower
    wirelesstools
    iw
    unzip
  ];

}
