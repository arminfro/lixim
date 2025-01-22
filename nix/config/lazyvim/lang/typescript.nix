self:
{
  pkgs,
  config,
  ...
}:
{
  extraPackages = [
    pkgs.vtsls
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.typescript"
  ];

  extraMasonPath = [
    {
      name = "packages/vtsls/node_modules/typescript";
      path = pkgs.vtsls;
    }
  ];
}
