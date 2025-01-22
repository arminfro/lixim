self:
{
  pkgs,
  ...
}:
{
  extraLazyImport = [
    "plugins.core.lang.astro"
  ];
}
