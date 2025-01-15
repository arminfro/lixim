self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    undotree
    nvim-various-textobjs
    nvim-config-local
    vim-repeat
    nvim-scissors
    nvim-window
    ts-node-action
    vim-mkdir
  ];

  extraLazyImport = [
    "plugins.core.editor"
  ];
}
