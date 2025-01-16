self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    otter-nvim
    nvim-docs-view
  ];

  extraLazyImport = [
    "plugins.max.editor"
  ];
}
