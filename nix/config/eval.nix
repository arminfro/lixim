{
  pkgs,
  self,
  config,
  lib,
}:
let
  liximConfig =
    (pkgs.lib.evalModules {
      modules = [
        (import ./default.nix self)
      ];

      specialArgs = {
        inherit
          pkgs
          config
          ;
        utils = rec {
          buildVimPlugin =
            {
              name,
              version ? "*",
              dependencies ? [ ],
              nvimSkipModule ? null,
            }:
            let
              subbedName = builtins.replaceStrings [ "." ] [ "-" ] name;
            in
            (pkgs.vimUtils.buildVimPlugin {
              inherit
                version
                dependencies
                nvimSkipModule
                ;
              pname = name;
              src = self.inputs.${subbedName};
            });

          buildVimPlugins = plugins: builtins.map (plugin: buildVimPlugin (plugin)) plugins;
        };
      };
    }).config;

  mkEntryFromDrv =
    drv:
    if lib.isDerivation drv then
      {
        name = "${lib.getName drv}";
        path = drv;
      }
    else
      drv;
in
rec {
  inherit (liximConfig) extraPackages;
  pluginPath = pkgs.linkFarm "lazyvim-nix-plugins" (builtins.map mkEntryFromDrv liximConfig.plugins);
  runtimePath = pkgs.symlinkJoin {
    name = "lazyvim-nix-runtime";
    paths = liximConfig.extraPackages;
  };
  treesitterPath = pkgs.symlinkJoin {
    name = "lazyvim-nix-treesitter-parsers";
    paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
  };
  snippetPath =
    if builtins.hasAttr "snippetsPath" config && config.snippetsPath != null then
      "vim.env.SNIPPETS_PATH = \"${builtins.toString config.snippetsPath}\""
    else
      "";
  zkNotebookPath =
    if builtins.hasAttr "zkNotebookPath" config && config.zkNotebookPath != null then
      "vim.env.ZK_NOTEBOOK_DIR = \"${builtins.toString config.zkNotebookPath}\""
    else
      "";

  openAiApiPasswordCommand =
    if
      builtins.hasAttr "openAiApiPasswordCommand" config && config.openAiApiPasswordCommand != null
    then
      "vim.env.OPENAI_API_KEY_CMD = \"${config.openAiApiPasswordCommand}\""
    else
      "";

  masonPath = pkgs.linkFarm "lazyvim-nix-mason" liximConfig.extraMasonPath;
  neovimPackage =
    if builtins.hasAttr "useNeovimNightly" config && config.useNeovimNightly then
      self.inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    else
      pkgs.neovim-unwrapped;

  customRC = # vim
    ''
      let g:config_path = "${../../config}"
      let g:plugin_path = "${pluginPath}"
      let g:runtime_path = "${runtimePath}"
      let g:treesitter_path = "${treesitterPath}"

      lua << EOF
        vim.env.MASON = "${masonPath}"
        ${snippetPath}
        ${zkNotebookPath}
        ${openAiApiPasswordCommand}

        vim.g.extra_lazy_import = {
          ${lib.concatStrings (
            builtins.map (extraImport: "{ import = \"${extraImport}\" },\n") liximConfig.extraLazyImport
          )}
        }

        vim.g.lixim_config = {
            cmpDicts = {
              en = "${../../config/dicts/en.dict}",
              de = "${../../config/dicts/de.dict}",
            },
        }

        ${lib.concatStrings liximConfig.extraLuaConfig}
      EOF

      source ${../../config/init.lua}
    '';
}
