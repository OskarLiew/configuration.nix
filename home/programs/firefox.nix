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
      inherit extensions settings;
    };
    work = {
      id = 1;
      extensions = extensions ++ [ ];
      settings = settings // { };
    };

  };
  mkDesktopEntry = name: {
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
      languagePacks = [ "en-US" "sv" ];
      inherit profiles;
    };
  };

  xdg.desktopEntries = builtins.listToAttrs (map
    (name: {
      inherit name;
      value = mkDesktopEntry name;
    })
    (builtins.attrNames profiles));
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "application/pdf" = "firefox.desktop";
    };
  };

  home.sessionVariables.BROWSER = "firefox";
}

