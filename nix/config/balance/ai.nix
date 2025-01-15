self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    avante-nvim
  ];

  extraLazyImport = [
    "plugins.balance.ai"
  ];
}
