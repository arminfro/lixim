self:
{
  pkgs,
  config,
  lib,
  ...
}:
{
  extraPackages = [
    pkgs.taplo
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.toml"
  ];
}
