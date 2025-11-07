{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./gaming.nix
    ../programs/syncthing.nix
    ../programs/vscode.nix
    ../programs/firefox.nix
    ../programs/chromium.nix
    ../theme
  ];

  home.packages = with pkgs; [
    # Apps
    qbittorrent
    (pkgs.callPackage ../packages/filebot.nix { })
    mullvad-browser
    jellyfin-media-player

    # Productivity
    bruno
    zotero
    bitwarden-desktop
    bitwarden-cli

    # Work
    slack
    zoom-us
  ];

  programs = {
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 2;
        enable_audio_bell = false;
        background_opacity = lib.mkForce 0.9;
        window_padding_width = 4;
      };
    };
    autorandr.enable = true;

    thunderbird = {
      enable = true;
      profiles.email.isDefault = true;
    };
  };

  services = {
    autorandr.enable = true;
    flameshot = {
      # https://github.com/flameshot-org/flameshot/issues/3328
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;
        };
      };
    };
  };

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "nvim.desktop" ];
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
        exec = "${config.home.sessionVariables.TERMINAL} -e yazi";
        terminal = false;
        type = "Application";
        categories = [
          "Utility"
          "Core"
          "System"
          "FileTools"
          "FileManager"
          "ConsoleOnly"
        ];
        mimeType = [ "inode/directory" ];
      };
      nvim = {
        name = "Neovim";
        icon = "nvim";
        exec = "${config.home.sessionVariables.TERMINAL} -e nvim";
        terminal = false;
        type = "Application";
        categories = [
          "Utility"
          "TextEditor"
        ];
        mimeType = [
          "text/english"
          "text/plain"
          "text/x-makefile"
          "text/x-c++hdr"
          "text/x-c++src"
          "text/x-chdr"
          "text/x-csrc"
          "text/x-java"
          "text/x-moc"
          "text/x-pascal"
          "text/x-tcl"
          "text/x-tex"
          "application/x-shellscript"
          "text/x-c"
          "text/x-c++"
        ];
      };
      btop = {
        name = "btop";
        icon = "btop";
        exec = "${config.home.sessionVariables.TERMINAL} -e btop";
        terminal = false;
        type = "Application";
        categories = [
          "Utility"
          "Core"
          "System"
        ];
      };
    };
  };
}
