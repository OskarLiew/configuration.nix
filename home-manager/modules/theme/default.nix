{ pkgs, ... }:
let
  colorscheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
in
{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 28;
    x11.enable = true;
    gtk.enable = true;
  };

  # Stylix
  stylix.enable = true;
  stylix.base16Scheme = colorscheme;

}
