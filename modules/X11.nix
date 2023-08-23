{ pkgs, ... }: {
  # Configure keymap in X11
  services.xserver = {
    layout = "se,us";
    xkbVariant = "";
    xkbOptions = "grp:rctrl_rshift_toggle";
  };

  # Enable touchpad support
  services.xserver.libinput = {
    enable = true;

    touchpad = {
      naturalScrolling = true;
      accelProfile = "flat";
      accelSpeed = "0.9";
    };
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
  ];

  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "${import ../packages/sddm-theme.nix { inherit pkgs; }}";
  };

  hardware.acpilight.enable = true;
}
