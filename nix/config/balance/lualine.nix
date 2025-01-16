self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    git-blame-nvim
    lualine-so-fancy-nvim
    lualine-spell-status
  ];

  extraLazyImport = [
    "plugins.balance.lualine"
  ];
}
