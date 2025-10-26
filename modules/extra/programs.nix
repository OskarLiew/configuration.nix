{ pkgs, upkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    upkgs.obsidian # Notes
    nautilus # File browser
    qimgv # Lightweight image viewer
    pinta # Light image editor
    gimp # Heavier image editor
    inkscape # Vector graphics editor
    libreoffice # Office suite
    obs-studio # Screen recorder
    mpv # Video player
    audacity # Audio editor
    spotify # Spotify
    discord # Discord
    kitty # Terminal
    papers # PDF viewer
  ];

  xdg.mime = {
    enable = true;
    defaultApplications = {
      # Documents
      "application/pdf" = "papers.desktop";
      "application/vnd.oasis.opendocument.text" = "libreoffice.desktop";
      "application/msword" = "libreoffice.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "libreoffice.desktop";
      "application/vnd.ms-excel" = "libreoffice.desktop";
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "libreoffice.desktop";
      "application/vnd.ms-powerpoint" = "libreoffice.desktop";
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "libreoffice.desktop";

      # Images
      "image/png" = "qimgv.desktop";
      "image/jpeg" = "qimgv.desktop";
      "image/svg+xml" = "inkscape.desktop";

      # Audio & Video
      "audio/mpeg" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "audio/wav" = "mpv.desktop";

      # Text
      "text/plain" = "obsidian.desktop";

      # Web / Communications
      "x-scheme-handler/discord" = "discord.desktop"; # Optional

      # File browser default (fallback)
      "inode/directory" = "nautilus.desktop";
    };

  };

  environment.sessionVariables = {
    TERMINAL = "kitty";
  };

  programs = {
    localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}

