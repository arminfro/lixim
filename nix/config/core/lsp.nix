self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    lsp_lines-nvim
    actions-preview-nvim
  ];

  extraPackages = [ pkgs.emmet-language-server ];

  extraLazyImport = [
    "plugins.core.lsp"
  ];
}
