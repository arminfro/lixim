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
}
