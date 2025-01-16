self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    nvim-scrollbar
    nvim-ufo
  ];

  extraLazyImport = [
    "plugins.max.ui"
  ];
}
