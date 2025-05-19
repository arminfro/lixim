self:
{
  pkgs,
  config,
  lib,
  utils,
  ...
}:
{
  extraPackages = with pkgs; [
    just
    just-lsp
  ];

  extraLazyImport = [
    "plugins.core.lang.just"
  ];
}
