self:
{
  pkgs,
  ...
}:
{
  extraLazyImport = [
    "plugins.core.snacks_picker"
  ];
}
