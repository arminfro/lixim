self:
{
  pkgs,
  ...
}:
{
  plugins = [
    pkgs.vimPlugins.edgy-nvim
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.ui.edgy"
  ];
}
