self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    mini-surround
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.coding.mini-surround"
  ];
}
