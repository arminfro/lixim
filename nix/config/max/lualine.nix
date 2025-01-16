self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    lualine-diagnostic-message
    nvim-dr-lsp
  ];

  extraLazyImport = [
    "plugins.max.lualine"
  ];
}
