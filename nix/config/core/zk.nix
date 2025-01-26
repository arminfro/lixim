self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    zk-nvim
  ];

  extraPackages = [
    pkgs.zk
  ];

  extraLazyImport = [
    "plugins.core.zk"
  ];
}
