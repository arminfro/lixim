self:
{
  utils,
  ...
}:
{
  plugins = utils.buildVimPlugins [
    { name = "lualine-so-fancy.nvim"; }
  ];

  extraLazyImport = [
    "plugins.core.lualine"
  ];
}
