alias u := update-inputs

default:
    just --list

update-inputs input='':
    nix flake update --flake $FLAKE {{ input }}
