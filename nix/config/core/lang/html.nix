self:
{
  pkgs,
  config,
  lib,
  ...
}:
{
  extraPackages = [
    pkgs.vscode-langservers-extracted
  ];

  extraLazyImport = [
    "plugins.core.lang.html"
  ];
}
