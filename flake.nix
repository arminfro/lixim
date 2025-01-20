{
  description = "Setup LazyVim using NixVim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
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
          ...
        }:
        let
          # Derivation containing all plugins
          pluginPath = import ./plugins.nix { inherit pkgs lib inputs; };

          # Derivation containing all runtime dependencies
          runtimePath = import ./runtime.nix { inherit pkgs; };

          # Link together all treesitter grammars into single derivation
          treesitterPath = pkgs.symlinkJoin {
            name = "lazyvim-nix-treesitter-parsers";
            paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
          };

          # Use nightly neovim only ;)
          neovimNightly = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
          # Wrap neovim with custom init and plugins
          neovimWrapped = pkgs.wrapNeovim neovimNightly {
            configure = {
              customRC = # vim
                ''
                  " Populate paths to neovim
                  let g:config_path = "${./config}"
                  let g:plugin_path = "${pluginPath}"
                  let g:runtime_path = "${runtimePath}"
                  let g:treesitter_path = "${treesitterPath}"
                  " Begin initialization
                  source ${./config/init.lua}
                '';
              packages.all.start = [ pkgs.vimPlugins.lazy-nvim ];
            };
          };
        in
        {
          packages = rec {
            # Wrap neovim again to make runtime dependencies available
            nvim = pkgs.writeShellApplication {
              name = "nvim";
              runtimeInputs = [ runtimePath ];
              text = ''${neovimWrapped}/bin/nvim "$@"'';
            };
            default = nvim;
          };
        };
    };
}
