{ upkgs, inputs, ... }:
{

  home.packages = with upkgs; [
    # - Python
    mypy
    uv
    pyright
    # - js
    nodejs_22
    nodePackages.prettier
    biome
    # - lua
    lua
    stylua
    luarocks
    lua-language-server
    # - Go
    gopls
    # - C
    gcc
    llvmPackages_19.clang-tools
    # - Rust
    cargo
    rust-analyzer
    # - PHP
    php
    phpactor
    # LSPs
    nodePackages.bash-language-server
    nil
    nixd
    nixfmt
    docker-compose-language-service
    dockerfile-language-server
    taplo
    yaml-language-server
    vscode-langservers-extracted
    # Tools
    llm
    tree-sitter
  ];

  xdg = {
    configFile = {
      "snippets".source = ../config/snippets;
    };
    dataFile = {
      "awesome-code-doc".source = inputs.awesomewm-doc;
    };
  };

  # Add templates
  home.file."Templates/shells" = {
    source = ./shells;
    recursive = true;
  };

  programs = {
    go = {
      enable = true;
      goPath = "$XDG_DATA_HOME/go";
      package = upkgs.go;
    };
    ruff = {
      enable = true;
      package = upkgs.ruff;
      settings = {
        lint = {
          select = [
            "E"
            "F"
            "W"
            "C4"
            "B"
            "I"
            "PL"
          ];
          ignore = [
            "B008"
            "B905"
            "PLR2004"
            "PLR0913"
            "PLW2901"
          ];
          per-file-ignores = {
            "__init__.py" = [ "F401" ];
          };
        };
      };
    };
  };

}
