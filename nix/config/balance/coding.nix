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
      nvim-jqx
      # tiny-inline-diagnostic-nvim
    ]
    ++ utils.buildVimPlugins [
      { name = "hl_match_area.nvim"; }
      {
        name = "nvim-devdocs";
        nvimSkipModule = [
          "nvim-devdocs.build"
          "nvim-devdocs.completion"
          "nvim-devdocs.config"
          "nvim-devdocs"
          "nvim-devdocs.keymaps"
          "nvim-devdocs.list"
          "nvim-devdocs.log"
          "nvim-devdocs.operations"
          "nvim-devdocs.pickers"
        ];
      }
      { name = "template-string.nvim"; }
    ];

  extraLazyImport = [
    "plugins.balance.coding"
  ];
}
