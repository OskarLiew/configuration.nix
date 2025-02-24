# configuration.nix

My NixOS configuration files

## NixOS

### Installation

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

### Available machines

- nixbtw: Home laptop
- hopfield: Work GPU laptop

## Home-manager

### Prerequisites

- Install Nix v2.4 or higher
- Enable experimental features `nix` and `flakes`
  - In NixOS: Set
    `nix.settings.experimental-features = [ "nix-command" "flakes" ];`
  - In other distros: Add `experimental-features = nix-command flakes` to
    `.config/nix/nix.conf`

#### Non-NixOS

To ensure that desktop files are detected correctly, and that Nix apps have
priority, add the following to `~/.profile`

```sh
export XDG_DATA_DIRS=$HOME/.nix-profile/share:$HOME/.share:"${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"
```

Make sure to use one of the appropriate generic linux users when building
configuration.

### Installing home manager

You can install home-manager and build the config at the time time with
`nix run home-manager/<release> -- switch --flake path/to/repo#<user>` where
release is either `release-yy.mm` or `master`.

### Rebuilding

Apply or rebuild the configuration with

```sh
home-manager switch --flake /path/to/repo#<user>
```

### Users

- oskar: Configuration for NixOS
- oskar-generic: Configuration for non-NixOS
- oskar-generic-term: Configuration for non-NixOS without graphical apps
