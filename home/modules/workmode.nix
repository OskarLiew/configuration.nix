{ pkgs, ... }: {
  specialisation.work.configuration = {
    programs.firefox.profiles.work.isDefault = true;
  };

  home.packages = [
    (pkgs.writeShellScriptBin
      "workmode"
      ''
        latest_gen=$(home-manager generations | head -1 | awk '{print $NF}')
        source "$latest_gen/specialisation/work/activate"
      '')
  ];
}

