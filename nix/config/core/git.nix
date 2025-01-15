self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    diffview-nvim
    gitlinker-nvim
    vim-fugitive
    nvim-tinygit
  ];

  extraLazyImport = [
    "plugins.core.git"
  ];
}
