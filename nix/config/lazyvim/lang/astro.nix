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

  extraPackages = [ pkgs.astro-language-server ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.astro"
  ];

  extraMasonPath = [
    {
      name = "packages/astro-language-server/node_modules/@astrojs/ts-plugin";
      path = pkgs.astro-language-server;
    }
  ];
}
