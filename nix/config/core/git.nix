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
      diffview-nvim
      gitlinker-nvim
      vim-fugitive
    ]
    ++ utils.buildVimPlugins [

      {
        name = "nvim-tinygit";
        nvimSkipModule = [
          "tinygit.commands.staging.telescope"
          "tinygit.statusline.branch-state"
        ];
      }
    ];

  extraLazyImport = [
    "plugins.core.git"
  ];
}
