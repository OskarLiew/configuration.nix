{
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

  services.xserver.displayManager = { sddm.enable = true; };

}
