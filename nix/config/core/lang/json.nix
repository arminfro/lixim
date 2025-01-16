self:
{
  pkgs,
  config,
  lib,
  ...
}:
{
  plugins = [
    {
      name = "jsonpath.nvim";
      path = pkgs.vimPlugins.jsonpath-nvim;
    }
  ];

  extraLazyImport = [
    "plugins.core.lang.json"
  ];
}
