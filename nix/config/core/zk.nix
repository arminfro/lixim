self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    zk-nvim
  ];

  extraLazyImport = [
    "plugins.core.zk"
  ];
}
