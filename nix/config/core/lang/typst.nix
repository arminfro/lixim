self:
{
  pkgs,
  ...
}:
{
  extraPackages = with pkgs; [
    tinymist # typst lsp
    typstyle # typst formatter
    websocat # typst-preview ws support
  ];

  plugins = [ pkgs.vimPlugins.typst-preview-nvim ];

  extraLazyImport = [
    "plugins.core.lang.typst"
  ];
}
