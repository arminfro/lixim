self:
{
  pkgs,
  ...
}:
{
  extraPackages = [
    pkgs.vscode-langservers-extracted
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.linting.eslint"
  ];
}
