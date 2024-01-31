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
    wget
    unzip
    playerctl
    htop

    # Apps
    chromium

    # Languages
    python311
    python311Packages.pip
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
      vimAlias = true;
    };
    git.enable = true;
  };

  services = {
    gvfs.enable = true;
  };

}
