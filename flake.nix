{
  description = "neovim editor with custom lazyvim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    tailwindcss-colorizer-cmp-nvim.url = "github:roobert/tailwindcss-colorizer-cmp.nvim";
    tailwindcss-colorizer-cmp-nvim.flake = false;
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake
      {
        inherit inputs;
      }
      {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "aarch64-darwin"
          "x86_64-darwin"
        ];

        perSystem =
          {
            pkgs,
            lib,
            system,
            config,
            ...
          }:
          {
            _module.args.pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = import ./nix/overlays.nix { inherit self pkgs; };
            };

            packages =
              let
                defaultNeovimConfig = {
                  lang = {
                    git.enable = true;
                    json.enable = true;
                    markdown.enable = true;
                    nix.enable = true;
                    tailwind.enable = true;
                    typescript.enable = true;
                  };
                };
                neovimByConfig =
                  config:
                  import ./nix {
                    inherit
                      pkgs
                      lib
                      inputs
                      self
                      config
                      ;

                  };
              in
              rec {
                lazyvim = neovimByConfig ({ enableLvl = "lazyvim"; } // defaultNeovimConfig);
                # core = neovimByConfig ({ enableLvl = "core"; } // defaultConfig);
                # balance = neovimByConfig ({ enableLvl = "balance"; } // defaultConfig);
                # max = neovimByConfig ({ enableLvl = "max"; } // defaultConfig);
                default = lazyvim;
              };
          };
      };
}
