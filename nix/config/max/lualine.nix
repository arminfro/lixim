self:
{
  pkgs,
  utils,
  ...
}:
{
  plugins = utils.buildVimPlugins [
    { name = "nvim-dr-lsp"; }
  ];

  extraLazyImport = [
    "plugins.max.lualine"
  ];
}
