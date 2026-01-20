{ pkgs, ... }:
let
  imgLink = "https://i.ibb.co/vHymspV/everforest-themed-nixos-wallpaper-i-made-which-isnt-literal-v0-y3o84lcin07b1.png";
  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "sha256-GAbOVmO1sievwNOBZcxfX27j1AULScm260g8eXqwMSs=";
  };
  fg = "#D3C6AA";
  bg0 = "#272E33";
  bg1 = "#2E383C";
  bg2 = "#374145";
  bgRed = "#493B40";
  green = "#A7C080";
  bgGreen = "#3C4841";
  bgVisual = "#4C3743";
in
{
  # Display manager, e.g. login screen
  services.displayManager.sddm = {
    enable = true;
    extraPackages = with pkgs; [
      sddm-astronaut
      kdePackages.qtbase
      kdePackages.qtmultimedia
    ];
    theme = "sddm-astronaut-theme";
    settings.Theme.Current = "sddm-astronaut-theme";
  };
  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override {
      themeConfig = {
        Background = "${image}";

        HeaderTextColor = fg;
        DateTextColor = fg;
        TimeTextColor = fg;

        FormBackgroundColor = bg1;
        BackgroundColor = bg0;
        DimBackgroundColor = bg0;

        LoginFieldBackgroundColor = "#000000";
        PasswordFieldBackgroundColor = "#000000";
        LoginFieldTextColor = fg;
        PasswordFieldTextColor = fg;
        UserIconColor = fg;
        PasswordIconColor = fg;

        PlaceholderTextColor = fg;
        WarningColor = bgRed;

        LoginButtonTextColor = bg0;
        LoginButtonBackgroundColor = green;
        SystemButtonsIconsColor = fg;
        SessionButtonTextColor = fg;
        VirtualKeyboardButtonTextColor = fg;

        HoverUserIconColor = green;
        HoverPasswordIconColor = green;
        HoverSystemButtonsIconsColor = green;
        HoverSessionButtonTextColor = green;
        HoverVirtualKeyboardButtonTextColor = green;

        DropdownTextColor = fg;
        DropdownSelectedBackgroundColor = bgGreen;
        DropdownBackgroundColor = bg2;

        HighlightTextColor = fg;
        HighlightBackgroundColor = bgVisual;
        HighlightBorderColor = bgVisual;

        FormPosition = "left";
        Blur = "0.0";
      };
    })
    kdePackages.qtbase
    kdePackages.qtmultimedia
  ];

}
