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
      nvim-scrollbar
      nvim-ufo
    ]
    ++ utils.buildVimPlugins [
      {
        name = "neominimap.nvim";
      }
    ];

  extraLazyImport = [
    "plugins.max.ui"
  ];
}
