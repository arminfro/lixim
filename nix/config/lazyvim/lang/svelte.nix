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

  extraMasonPath = [
    {
      name = "packages/svelte-language-server/node_modules/typescript-svelte-plugin";
      path = pkgs.svelte-language-server;
    }
  ];
}
