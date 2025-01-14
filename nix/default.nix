{
  pkgs,
  lib,
  inputs,
  self,
  config,
}:
let
  mkEntryFromDrv =
    drv:
    if lib.isDerivation drv then
      {
        name = "${lib.getName drv}";
        path = drv;
      }
    else
      drv;

  configEval =
    (pkgs.lib.evalModules {
      modules = [
        (import ./config self)
      ];
      specialArgs = {
        inherit
          # inputs
          # lib
          pkgs
          config
          ;
      };

    }).config;

  config2 = builtins.trace configEval configEval;

  # Derivation containing all plugins
  pluginPath = pkgs.linkFarm "lazyvim-nix-plugins" (builtins.map mkEntryFromDrv config2.plugins);

  # Derivation containing all runtime dependencies
  runtimePath = pkgs.symlinkJoin {
    name = "lazyvim-nix-runtime";
    paths = config2.extraPackages;
  };

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
          let g:config_path = "${../config}"
          let g:plugin_path = "${pluginPath}"
          let g:runtime_path = "${runtimePath}"
          let g:treesitter_path = "${treesitterPath}"

          lua << EOF
            vim.g.extra_lazy_import = {
              ${lib.concatStrings (
                builtins.map (extraImport: "{ import = \"${extraImport}\" },") config2.extraLazyImport
              )}
            }
            ${config2.extraLuaConfig}
          EOF

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
