self:
{
  pkgs,
  ...
}:
{
  plugins = [
    pkgs.vimPlugins.nvim-treesitter-context
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.ui.treesitter-context"
  ];
}
