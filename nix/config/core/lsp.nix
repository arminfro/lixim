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

  extraLazyImport = [
    "plugins.core.lsp"
  ];
}
