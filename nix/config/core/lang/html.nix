self:
{
  pkgs,
  ...
}:
{
  extraPackages = with pkgs; [
    vscode-langservers-extracted
    htmlhint
  ];

  extraLazyImport = [
    "plugins.core.lang.html"
  ];
}
