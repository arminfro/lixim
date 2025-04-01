self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    codecompanion-nvim
  ];

  extraLazyImport = [
    "plugins.balance.ai"
  ];
}
