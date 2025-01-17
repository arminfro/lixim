self:
{
  pkgs,
utils,
  ...
}:
{
  plugins = utils.buildVimPlugins [
    { name = "git-blame.nvim"; }
    { name = "lualine-so-fancy.nvim"; }
    { name = "lualine-spell-status"; }
    ];

  extraLazyImport = [
    "plugins.balance.lualine"
  ];
}
