{ pkgs, ... }: {
  # Display manager, e.g. login screen
  services.displayManager.sddm = {
    enable = true;
    theme = "${import ../../packages/sddm-theme.nix { inherit pkgs; }}";
  };

}
