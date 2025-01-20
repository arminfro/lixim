self:
{
  pkgs,
  utils,
  ...
}:
{
  plugins =
    with pkgs.vimPlugins;
    [
      undotree
      nvim-various-textobjs
      nvim-config-local
      vim-repeat
      oil-nvim
    ]
    ++ utils.buildVimPlugins [
      {
        name = "nvim-scissors";
        nvimSkipModule = "scissors.2-picker.telescope";
      }
      { name = "nvim-window"; }
      { name = "ts-node-action"; }
      { name = "vim-mkdir"; }
    ];

  extraLazyImport = [
    "plugins.core.editor"
  ];
}
