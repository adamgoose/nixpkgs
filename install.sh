#!/bin/bash

/home/gitpod/.nix-profile/bin/nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
/home/gitpod/.nix-profile/bin/nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

/home/gitpod/.nix-profile/bin/nix-shell '<home-manager>' -A install

home-manager switch --flake .#gitpod
