{ pkgs, ... }:
let gruvboxPlus = import ../../packages/gruvbox-plus.nix { inherit pkgs; };
in {

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "adwaita-dark";
      # detected automatically:
      # adwaita, adwaita-dark, adwaita-highcontrast,
      # adwaita-highcontrastinverse, breeze,
      # bb10bright, bb10dark, cde, cleanlooks,
      # gtk2, motif, plastique
      package = pkgs.adwaita-qt;
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibara-Modern-Ice";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    iconTheme = {
      package = gruvboxPlus;
      name = "GruvboxPlus";
    };
  };

}
