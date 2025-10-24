{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # CLIs
    procps # ps, kill, watch, ...
    lsof # list open files
    psmisc # fuser, killall, ...
    dconf # KV-store
    tmux
    curl
    wget
    unzip
    parallel
    btop
    trash-cli
    fastfetch
    ripgrep
    tree
    fd
    jq
    yq
    gh

    # Code
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
      enableCompletion = true;
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
    lazygit.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
      enableSSHSupport = true;
    };
    less.enable = true;
    bat.enable = true;
    fzf = {
      fuzzyCompletion = true;
      keybindings = true;
    };
    firefox = {
      enable = true;
      languagePacks = [ "en-US" "sv-SE" ];
    };
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  services = {
    # Virtual filesystem for trash
    gvfs.enable = true;
  };

}
