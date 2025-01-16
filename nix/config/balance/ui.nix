self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    nvim-hlslens
    urlview-nvim
    nvim-origami
  ];

  extraLazyImport = [
    "plugins.balance.ui"
  ];
}
