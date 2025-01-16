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
    nvim-tinygit = {
      url = "github:chrisgrieser/nvim-tinygit";
      flake = false;
    };
    markdowny-nvim = {
      url = "github:antonk52/markdowny.nvim";
      flake = false;
    };
    auto-pandoc-nvim = {
      url = "github:jghauser/auto-pandoc.nvim";
      flake = false;
    };
    nvim-toc = {
      url = "github:richardbizik/nvim-toc";
      flake = false;
    };
    mdeval-nvim = {
      url = "github:jubnzv/mdeval.nvim";
      flake = false;
    };
    hl_match_area-nvim = {
      url = "github:rareitems/hl_match_area.nvim";
      flake = false;
    };
    nvim-devdocs = {
      url = "github:luckasRanarison/nvim-devdocs";
      flake = false;
    };
    template-string-nvim = {
      url = "github:axelvc/template-string.nvim";
      flake = false;
    };
    fsread-nvim = {
      url = "github:nullchilly/fsread.nvim";
      flake = false;
    };
    nvim-fundo = {
      url = "github:kevinhwang91/nvim-fundo";
      flake = false;
    };
    promise-async = {
      url = "github:kevinhwang91/promise-async";
      flake = false;
    };
    hand-side-fix-nvim = {
      url = "github:arminfro/hand-side-fix.nvim";
      flake = false;
    };
    git-blame-nvim = {
      url = "github:f-person/git-blame.nvim";
      flake = false;
    };
    lualine-so-fancy-nvim = {
      url = "github:meuter/lualine-so-fancy.nvim";
      flake = false;
    };
    lualine-diagnostic-message = {
      url = "github:Isrothy/lualine-diagnostic-message";
      flake = false;
    };
    nvim-dr-lsp = {
      url = "github:chrisgrieser/nvim-dr-lsp";
      flake = false;
    };
    lualine-spell-status = {
      url = "github:sherlock5512/lualine-spell-status";
      flake = false;
    };
    nvim-origami = {
      url = "github:chrisgrieser/nvim-origami";
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
                balance = neovimByConfig ({ enableLvl = "balance"; } // defaultNeovimConfig);
                max = neovimByConfig ({ enableLvl = "max"; } // defaultNeovimConfig);
                default = max;
              };
          };
      };
}
