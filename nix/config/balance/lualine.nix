self:
{
  pkgs,
  utils,
  ...
}:
{
  plugins = utils.buildVimPlugins [
    { name = "git-blame.nvim"; }
    { name = "lualine-spell-status"; }
  ];

  extraLazyImport = [
    "plugins.balance.lualine"
  ];
}
