self:
{
  pkgs,
  config,
  lib,
  ...
}:
{
  extraPackages = [
    pkgs.svelte-language-server
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.svelte"
  ];
}
