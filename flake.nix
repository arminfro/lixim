{
  description = "neovim editor with custom lazyvim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    tailwindcss-colorizer-cmp-nvim = {
      url = "github:roobert/tailwindcss-colorizer-cmp.nvim";
      flake = false;
    };
    blink-cmp-dictionary = {
      url = "github:Kaiser-Yang/blink-cmp-dictionary";
      flake = false;
    };
    telescope-alternate = {
      url = "github:otavioschwanck/telescope-alternate";
      flake = false;
    };
    telescope-lazy-nvim = {
      url = "github:tsakirist/telescope-lazy.nvim";
      flake = false;
    };
    telescope-node-modules-nvim = {
      url = "github:nvim-telescope/telescope-node-modules.nvim";
      flake = false;
    };
    telescope-heading-nvim = {
      url = "github:crispgm/telescope-heading.nvim";
      flake = false;
    };
    telescope-env-nvim = {
      url = "github:LinArcX/telescope-env.nvim";
      flake = false;
    };
    telescope-luasnip-nvim = {
      url = "github:benfowler/telescope-luasnip.nvim";
      flake = false;
    };
    ts-node-action = {
      url = "github:CKolkey/ts-node-action";
      flake = false;
    };
    vim-mkdir = {
      url = "github:pbrisbin/vim-mkdir";
      flake = false;
    };
    nvim-scissors = {
      url = "github:chrisgrieser/nvim-scissors";
      flake = false;
    };
    nvim-window = {
      url = "github:yorickpeterse/nvim-window";
      flake = false;
    };
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
                core = neovimByConfig ({ enableLvl = "core"; } // defaultNeovimConfig);
                # balance = neovimByConfig ({ enableLvl = "balance"; } // defaultNeovimConfig);
                # max = neovimByConfig ({ enableLvl = "max"; } // defaultNeovimConfig);
                default = core;
              };
          };
      };
}
