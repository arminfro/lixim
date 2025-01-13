{
  pkgs,
  lib,
  inputs,
}:
let
  # Derivation containing all plugins
  pluginPath = import ./plugins { inherit pkgs lib inputs; };

  # Derivation containing all runtime dependencies
  runtimePath = import ./runtime { inherit pkgs; };

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
          let g:config_path = "${../config}"
          let g:plugin_path = "${pluginPath}"
          let g:runtime_path = "${runtimePath}"
          let g:treesitter_path = "${treesitterPath}"
          " Begin initialization
          source ${../config/init.lua}
        '';
      packages.all.start = [ pkgs.vimPlugins.lazy-nvim ];
    };
  };
in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ runtimePath ];
  text = ''${neovimWrapped}/bin/nvim "$@"'';
}
