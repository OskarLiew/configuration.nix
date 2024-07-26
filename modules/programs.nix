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

    # Tools
    wget
    unzip
    playerctl
    htop
    openssh
    parallel

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
      histFile = "$XDG_DATA_HOME/zsh/history";
      setOptions = [ ];
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };
    git.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
      enableSSHSupport = true;
    };
  };

  services = {
    gvfs.enable = true;
  };

}
