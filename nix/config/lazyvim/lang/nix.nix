self:
{
  pkgs,
  config,
  ...
}:
let
  enable = config.lang.nix.enable;
  emptyListOr = list: if enable then list else [ ];
in
{
  extraPackages = emptyListOr (
    with pkgs;
    [
      nil
      nixfmt-rfc-style
    ]
  );

  plugins = emptyListOr (
    with pkgs.vimPlugins;
    [
      (nvim-treesitter.withPlugins (plugins: [ plugins.nix ]))
    ]
  );

  extraLazyImport = emptyListOr [
    "lazyvim.plugins.extras.lang.nix"
  ];
}
