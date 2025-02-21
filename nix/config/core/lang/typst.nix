self:
{
  pkgs,
  ...
}:
{
  extraPackages = with pkgs; [
    tinymist # typst lsp
    typstyle # typst formatter
  ];

  extraLazyImport = [
    "plugins.core.lang.typst"
  ];
}
