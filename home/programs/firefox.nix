{ pkgs, ... }: {

  programs = {
    firefox = {
      enable = true;
      profiles.work = {
        id = 0;
        extensions = [ ];
      };
    };
  };

}

