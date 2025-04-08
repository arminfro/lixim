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
      img-clip-nvim
      glow-nvim
    ]
    ++ utils.buildVimPlugins [
      { name = "markdowny.nvim"; }
      { name = "auto-pandoc.nvim"; }
      {
        name = "nvim-toc";
        dependencies = [
          pkgs.vimPlugins.nvim-treesitter
        ];
      }
      { name = "mdeval.nvim"; }
    ];

  extraPackages = with pkgs; [
    glow
    pandoc
  ];

  extraLazyImport = [
    "plugins.core.writing"
  ];
}
