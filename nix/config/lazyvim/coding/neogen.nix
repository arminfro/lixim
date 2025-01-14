self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    neogen
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.coding.neogen"
  ];
}
