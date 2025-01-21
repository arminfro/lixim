self:
{
  pkgs,
  ...
}:
{
  extraPackages = with pkgs; [
    stylelint-lsp
  ];

  extraLazyImport = [
    "plugins.core.lang.css"
  ];
}
