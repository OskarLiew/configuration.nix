{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userName = "Oskar Liew";
      userEmail = "oskar@liew.se";
      aliases = {
        co = "checkout";
        tree =
          "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      };
      delta = {
        enable = true;
        options = {
          syntax-theme = "ansi";
          # Nice colors for colorMoved
          map-styles = "bold purple => syntax rebeccapurple, bold cyan => syntax midnightblue";
        };
      };
      ignores = [
        ".direnv"
        ".envrc"
      ];
      extraConfig = {
        init.defaultBranch = "main";
        rerere = {
          # Reuse recorded resolution - Smoother rebases
          enabled = true;
          autoUpdate = true;
        };
        # Sort branches and tags
        branch.sort = "-committerdate";
        column.ui = "auto";
        tag.sort = "version:refname";
        # Better diffs
        diff.algorithm = "histogram";
        diff.colorMoved = "plain";
        diff.mnemonicPrefix = true;
        diff.renames = true;
        # Add diff to commit
        commit.verbose = true;
        # Set up fancy pager
        pager = {
          blame = "delta";
          diff = "delta";
          reflog = "delta";
          show = "delta";
        };
      };
    };
    lazygit = {
      enable = true;
      settings = {
        git = {
          paging = {
            colorArg = "always";
            pager = "delta --paging=never";
          };
        };
      };
    };
  };
}
