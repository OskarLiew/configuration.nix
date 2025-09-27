{ config, pkgs, upkgs, ... }: {
  imports = [ ./gaming.nix ../programs/syncthing.nix ../programs/vscode.nix ../programs/firefox.nix ../theme ];

  home.packages = with pkgs; [
    # Utils
    arandr
    dconf
    mpd
    simplescreenrecorder

    # Apps
    inkscape
    qbittorrent
    (pkgs.callPackage ../packages/filebot.nix { })
    gimp
    spotify
    discord
    vlc
    audacity
    mullvad-browser

    # Productivity
    nautilus
    upkgs.obsidian
    bruno
    zotero
    libreoffice

    # Other
    pkgs.nerd-fonts.fira-code

    # Work
    slack
    zoom-us
  ];

  programs = {
    chromium = {
      enable = true;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      ];
    };

    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 2;
        enable_audio_bell = false;
      };
    };
    autorandr.enable = true;
  };

  services = { autorandr.enable = true; };

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "nvim.desktop" ];
        "inode/directory" = "yazi.desktop";
      };
    };
    configFile = {
      "awesome".source = ../config/awesome;
      "picom".source = ../config/picom;
      "rofi/config".source = ../config/rofi/config;
      "rofi/color/colorscheme.rasi".text = with config.lib.stylix.colors; ''
        * {
            background:     #${base00}90;
            background-alt: #${base01}70;
            foreground:     #${base05}ff;
            selected:       #${base0D}ff;
            active:         #${base0B}30;
            urgent:         #${base08}ff;
        }
      '';
    };
    desktopEntries = {
      # Make apps open in kitty
      yazi = {
        name = "Yazi";
        icon = "yazi";
        exec = "kitty -e yazi";
        terminal = false;
        type = "Application";
        categories = [ "Utility" "Core" "System" "FileTools" "FileManager" "ConsoleOnly" ];
        mimeType = [ "inode/directory" ];
      };
      nvim = {
        name = "Neovim";
        icon = "nvim";
        exec = "kitty -e nvim";
        terminal = false;
        type = "Application";
        categories = [ "Utility" "TextEditor" ];
        mimeType = [ "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++" ];
      };
      btop = {
        name = "btop";
        icon = "btop";
        exec = "kitty -e btop";
        terminal = false;
        type = "Application";
        categories = [ "Utility" "Core" "System" ];
      };
    };
  };
}
