self:
{
  pkgs,
  utils,
  ...
}:
{
  plugins = utils.buildVimPlugins [
    { name = "lualine-diagnostic-message"; }
    { name = "nvim-dr-lsp"; }
  ];

  extraLazyImport = [
    "plugins.max.lualine"
  ];
}
