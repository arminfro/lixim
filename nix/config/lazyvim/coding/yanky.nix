self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    yanky-nvim
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.coding.yanky"
  ];
}
