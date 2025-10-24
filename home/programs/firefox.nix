{ pkgs, ... }:
let
  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    ublock-origin
    vimium
    zotero-connector
    bitwarden
    istilldontcareaboutcookies
  ];
  settings = {
    extensions.autoDisableScopes = 0;
    browser.tabs.inTitlebar = 0;
  };
  profiles = {
    home = {
      id = 0;
      inherit settings;
      extensions.packages = extensions;
    };
    work = {
      id = 1;
      extensions.packages = extensions ++ [ ];
      settings = settings // { };
    };

  };
  mkFirefoxDesktopEntry = name: {
    name = "Firefox ${name}";
    icon = "firefox";
    exec = "firefox -P ${name}";
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
  };
in
{
  programs = {
    firefox = {
      enable = true;
      languagePacks = [ "en-US" "sv-SE" ];
      inherit profiles;
    };
  };

  xdg.desktopEntries = {
    outlook = {
      name = "Outlook";
      exec = "firefox --app=https://outlook.office.com/mail/";
      icon = "${pkgs.fetchurl {
        url = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/microsoft-outlook.svg";
        sha256 = "sha256-3u8t5QNHFZvrAegxBiGicO4PjtMWhEaQSCv7MSSfLLc=";
      }}";
    };
    teams = {
      name = "Teams";
      exec = "firefox --app=https://teams.microsoft.com/v2/";
      icon = "${pkgs.fetchurl {
        url = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/microsoft-teams.svg";
        sha256 = "sha256-Pr9QS8nnXJq97r4/G3c6JXi34zxHl0ps9gcyI8cN/s8=";
      }}";
    };
    chatgpt = {
      name = "ChatGPT";
      exec = "firefox --app=https://chatgpt.com";
      icon = "${pkgs.fetchurl {
        url = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/chatgpt.svg";
        sha256 = "sha256-Wo2tKGTMHIEJ6650vqRH3y8wuXi9rVZ0kkfEBuHLIic=";
      }}";
    };
  } // builtins.listToAttrs (map
    (name: {
      inherit name;
      value = mkFirefoxDesktopEntry name;
    })
    (builtins.attrNames profiles));

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  stylix.targets.firefox.profileNames = builtins.attrNames profiles;

  home.sessionVariables.BROWSER = "firefox";
}

