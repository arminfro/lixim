self:
{
  pkgs,
  config,
  ...
}:
{
  extraPackages = (
    with pkgs;
    [
      nil
      nixfmt-rfc-style
    ]
  );

  plugins = (
    with pkgs.vimPlugins;
    [
      (nvim-treesitter.withPlugins (plugins: [ plugins.nix ]))
    ]
  );

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.nix"
  ];
}
