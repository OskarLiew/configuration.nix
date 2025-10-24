{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # CLIs
    procps # ps, kill, watch, ...
    lsof # list open files
    psmisc # fuser, killall, ...
    tmux
    curl
    wget
    unzip
    parallel
    btop

    # Apps
    firefox

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
