self:
{
  pkgs,
  config,
  lib,
  ...
}:
{
  extraPackages = [ pkgs.yaml-language-server ];

  plugins = [
    pkgs.vimPlugins.SchemaStore-nvim
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.yaml"
  ];
}
