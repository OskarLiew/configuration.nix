# Nix shells

Use with `nix-shell <path-to-shell.nix>`

## Nix flakes

Initialize a repo with `nix flake init --template templates#<template>`

The templates are a nix flake and can be a github repo. Here is a handy python one with uv

`nix flake init --template github:pyproject-nix/pyproject.nix#impure`

## Nix direnv

Use direnv to automatically enable the shell. To do so, use 

`direnv edit .`

Examples

```sh
use nix
# OR 
use flake

# You can also use
# dotenv .env
# source .venv/bin/activate
```

