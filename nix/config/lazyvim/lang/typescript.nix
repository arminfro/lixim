self:
{
  pkgs,
  config,
  ...
}:
let
  enable = config.lang.typescript.enable;
  emptyListOr = list: if enable then list else [ ];
in
{
  extraPackages = emptyListOr [
    pkgs.vtsls
  ];

  # plugins = with pkgs.vimPlugins; [
  #   (nvim-treesitter.withPlugins (plugins: [ plugins.nix ]))
  # ];

  extraLazyImport = emptyListOr [
    "lazyvim.plugins.extras.lang.typescript"
  ];
}
