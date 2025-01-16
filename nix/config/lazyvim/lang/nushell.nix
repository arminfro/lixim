self:
{
  pkgs,
  config,
  lib,
  ...
}:
{
  extraPackages = [
    pkgs.nushell
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.nushell"
  ];
}
