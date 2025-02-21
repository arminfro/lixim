self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    neo-tree-nvim
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.editor.neo-tree"
  ];
}
