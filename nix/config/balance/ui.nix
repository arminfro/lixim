self:
{
  pkgs,
  utils,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    nvim-hlslens
    urlview-nvim
  ];

  extraLazyImport = [
    "plugins.balance.ui"
  ];
}
