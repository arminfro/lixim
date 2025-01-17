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

  liximConfig =
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

  # Derivation containing all plugins
  pluginPath = pkgs.linkFarm "lazyvim-nix-plugins" (builtins.map mkEntryFromDrv liximConfig.plugins);

  # Derivation containing all runtime dependencies
  runtimePath = pkgs.symlinkJoin {
    name = "lazyvim-nix-runtime";
    paths = liximConfig.extraPackages;
  };

  # Link together all treesitter grammars into single derivation
  treesitterPath = pkgs.symlinkJoin {
    name = "lazyvim-nix-treesitter-parsers";
    paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
  };

  # For some lsp's mason warns about path issues, setting env to prevent that
  masonPath = pkgs.linkFarm "lazyvim-nix-mason" liximConfig.extraMasonPath;

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
            vim.env.MASON = "${masonPath}"

            vim.g.extra_lazy_import = {
              ${lib.concatStrings (
                builtins.map (extraImport: "{ import = \"${extraImport}\" },") liximConfig.extraLazyImport
              )}
            }

            -- todo, use dicts in markdwon
            -- vim.g.neovim_config = {
            --     cmpDicts = {
            --       en = "${../config/dicts/english.dict}",
            --       de = "${../config/dicts/german.dict}",
            --     },
            -- }

            ${liximConfig.extraLuaConfig}
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
