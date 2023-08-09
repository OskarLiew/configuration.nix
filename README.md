# configuration.nix

My NixOS configuration files

## Installation

The configuration is based on flakes, and the main entrypoint is `flake.nix`. Before
installing my configuration, you must first enable flakes and the nix command. This
can be done by adding

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];

```

to `/etc/nixos/configuration.nix` and then rebuilding with `sudo nixos-rebuild switch`.
Then you can build the system with

```sh
git clone https://github.com/OskarLiew/configuration.nix
sudo nixos-rebuild switch --flake path/to/repo#<machine>
```

The placeholder `<machine>` can be left empty to get the default configuration, or
replaced with a specific machine host name.

## Available machines

- nixbtw: Home laptop

