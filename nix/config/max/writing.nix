self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    mistake-nvim
  ];

  extraLazyImport = [
    "plugins.max.writing"
  ];
}
