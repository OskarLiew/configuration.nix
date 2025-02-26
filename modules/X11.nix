{ pkgs, ... }: {
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,se";
    variant = "";
    options = "grp:rctrl_rshift_toggle,grp:switch";
  };

  # Enable touchpad support
  services.libinput = {
    enable = true;

    touchpad = {
      naturalScrolling = true;
      accelProfile = "flat";
      accelSpeed = "0.9";
      disableWhileTyping = true;
    };

    mouse = {
      accelProfile = "flat";
    };
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    arandr
  ];

  services.displayManager.sddm = {
    enable = true;
    theme = "${import ../packages/sddm-theme.nix { inherit pkgs; }}";
  };

  services.autorandr.enable = true;

  hardware.acpilight.enable = true;
}
