{
  description = "lixim - neovim editor with custom lazyvim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    bacon-ls.url = "github:crisidev/bacon-ls";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    LazyVim = {
      url = "github:LazyVim/LazyVim";
      flake = false;
    };
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
    nvim-dr-lsp = {
      url = "github:chrisgrieser/nvim-dr-lsp";
      flake = false;
    };
    lualine-spell-status = {
      url = "github:sherlock5512/lualine-spell-status";
      flake = false;
    };
    mistake-nvim = {
      url = "github:ck-zhang/mistake.nvim";
      flake = false;
    };
    jsonpath-nvim = {
      url = "github:phelipetls/jsonpath.nvim";
      flake = false;
    };
    git-dev-nvim = {
      url = "github:moyiz/git-dev.nvim";
      flake = false;
    };
    smear-cursor-nvim = {
      url = "github:sphamba/smear-cursor.nvim";
      flake = false;
    };
    output-panel-nvim = {
      url = "github:mhanberg/output-panel.nvim";
      flake = false;
    };
    refjump-nvim = {
      url = "github:mawkler/refjump.nvim";
      flake = false;
    };
    neominimap-nvim = {
      url = "github:Isrothy/neominimap.nvim";
      flake = false;
    };
    cmp-pandoc-references = {
      url = "github:jmbuhr/cmp-pandoc-references";
      flake = false;
    };
    venv-selector-nvim = {
      url = "github:linux-cultist/venv-selector.nvim";
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
          # "aarch64-darwin"
          # "x86_64-darwin"
        ];
        flake = {
          hydraJobs = {
            inherit (self)
              packages
              ;
          };

          nixosModules.default = import ./nix {
            inherit self;
            isNixOsModule = true;
          };

          homeManagerModules.default = import ./nix {
            inherit self;
            isNixOsModule = false;
          };
        };

        perSystem =
          {
            pkgs,
            lib,
            system,
            config,
            ...
          }:
          {
            packages = import ./nix/packages {
              inherit
                pkgs
                self
                lib
                ;
            };
          };
      };
}
