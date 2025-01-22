self:
{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    (import ./typescript.nix self)
  ];

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
