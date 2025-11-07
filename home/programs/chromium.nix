{ pkgs, ... }:
let
  chromium = pkgs.chromium;
in
{
  programs.chromium = {
    enable = true;
    package = chromium;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
    ];
  };

  # Icons: https://dashboardicons.com
  xdg.desktopEntries = {
    outlook = {
      name = "Outlook";
      exec = "${chromium}/bin/chromium --app=https://outlook.office.com/mail/";
      icon = "${pkgs.fetchurl {
        url = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/microsoft-outlook.svg";
        sha256 = "sha256-3u8t5QNHFZvrAegxBiGicO4PjtMWhEaQSCv7MSSfLLc=";
      }}";
    };
    teams = {
      name = "Teams";
      exec = "${chromium}/bin/chromium --app=https://teams.microsoft.com/v2/";
      icon = "${pkgs.fetchurl {
        url = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/microsoft-teams.svg";
        sha256 = "sha256-Pr9QS8nnXJq97r4/G3c6JXi34zxHl0ps9gcyI8cN/s8=";
      }}";
    };
    chatgpt = {
      name = "ChatGPT";
      exec = "${chromium}/bin/chromium --app=https://chatgpt.com";
      icon = "${pkgs.fetchurl {
        url = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/chatgpt.svg";
        sha256 = "sha256-Wo2tKGTMHIEJ6650vqRH3y8wuXi9rVZ0kkfEBuHLIic=";
      }}";
    };
    youtube = {
      name = "YouTube";
      exec = "${chromium}/bin/chromium --app=https://youtube.com";
      icon = "${pkgs.fetchurl {
        url = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/youtube.svg";
        sha256 = "sha256-MgriIMU6YSbagar2gD2MgTg3vKqV853PX3WTIzV0ZnM=";
      }}";
    };
  };
}
