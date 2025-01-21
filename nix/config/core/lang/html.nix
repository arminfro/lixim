self:
{
  pkgs,
  ...
}:
{
  extraPackages = with pkgs; [
    vscode-langservers-extracted
    htmlhint
    superhtml
  ];

  extraLazyImport = [
    "plugins.core.lang.html"
  ];
}
