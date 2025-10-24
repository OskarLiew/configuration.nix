{ pkgs, ... }: {
  # Configure keymap with xkbd
  services.xserver.xkb = {
    layout = "us,se";
    variant = "";
    options = "grp:rctrl_rshift_toggle,grp:switch";
  };

  console.keyMap = "sv-latin1";

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

  # Tablet driver
  hardware.opentabletdriver.enable = true;
}

