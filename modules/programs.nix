{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Hardware
    pciutils
    pulseaudio
    acpilight
    procps
    upower
    wirelesstools
    iw

    # Productivity
    tmux
    vim

    # Tools
    home-manager
    wget
    unzip
    playerctl
    htop

    # Apps
    chromium

    # Languages
    python38
    python38Packages.pip
    python310
    python310Packages.pip
    lua
    gcc
    gnumake
    cmake
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = false;
      histSize = 10000;
      histFile = "$XDG_CACHE_HOME/zsh/history";
      setOptions = [ ];
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    git.enable = true;
  };

  services = {
    gvfs.enable = true;
  };

}
