self:
{
  pkgs,
  ...
}:
{
  extraPackages = with pkgs; [
    statix
  ];

  extraLazyImport = [
    "plugins.core.lang.nix"
  ];
}
