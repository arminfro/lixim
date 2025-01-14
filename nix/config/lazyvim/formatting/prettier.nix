self:
{
  pkgs,
  ...
}:
{
  extraPackages = [
    pkgs.nodePackages.prettier
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.formatting.prettier"
  ];
}
