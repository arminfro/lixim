self:
{
  pkgs,
  config,
  lib,
  ...
}:
let
  enable = config.lang.json.enable;
  emptyListOr = list: if enable then list else [ ];
in
{
  extraPackages = emptyListOr [ pkgs.vscode-langservers-extracted ];

  plugins = emptyListOr [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: [ plugins.json5 ]))
    pkgs.vimPlugins.SchemaStore-nvim
  ];

  extraLazyImport = emptyListOr [
    "lazyvim.plugins.extras.lang.json"
  ];
}
