self:
{
  pkgs,
  ...
}:
{
  extraPackages = [
    pkgs.biome
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.formatting.biome"
  ];
}
