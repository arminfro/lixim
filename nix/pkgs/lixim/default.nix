{
  pkgs,
  lib,
  self,
  config,
}:
let
  cfg = config;
  mkEntryFromDrv =
    drv:
    if lib.isDerivation drv then
      {
        name = "${lib.getName drv}";
        path = drv;
      }
    else
      drv;

  # Derivation containing all plugins
  pluginPath = pkgs.linkFarm "lazyvim-nix-plugins" (builtins.map mkEntryFromDrv cfg.plugins);

  # Derivation containing all runtime dependencies
  runtimePath = pkgs.symlinkJoin {
    name = "lazyvim-nix-runtime";
    paths = cfg.extraPackages;
  };

  # Link together all treesitter grammars into single derivation
  treesitterPath = pkgs.symlinkJoin {
    name = "lazyvim-nix-treesitter-parsers";
    paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
  };

  # For some lsp's mason warns about path issues, setting env to prevent that
  masonPath = pkgs.linkFarm "lazyvim-nix-mason" cfg.extraMasonPath;

  # Use nightly neovim only ;)
  neovimNightly = self.inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  # Wrap neovim with custom init and plugins
  neovimWrapped = pkgs.wrapNeovim neovimNightly {
    configure = {
      customRC = # vim
        ''
          let g:config_path = "${../../../config}"
          let g:plugin_path = "${pluginPath}"
          let g:runtime_path = "${runtimePath}"
          let g:treesitter_path = "${treesitterPath}"

          lua << EOF
            vim.env.MASON = "${masonPath}"

            vim.g.extra_lazy_import = {
              ${lib.concatStrings (
                builtins.map (extraImport: "{ import = \"${extraImport}\" },") cfg.extraLazyImport
              )}
            }

            -- todo, use dicts in markdwon
            -- vim.g.neovim_config = {
            --     cmpDicts = {
            --       en = "{../../config/dicts/english.dict}",
            --       de = "{../../config/dicts/german.dict}",
            --     },
            -- }

            ${lib.concatStrings cfg.extraLuaConfig}
          EOF

          source ${../../../config/init.lua}

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
