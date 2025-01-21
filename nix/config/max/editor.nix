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
      otter-nvim
      nvim-docs-view
    ]
    ++ utils.buildVimPlugins [
      { name = "git-dev.nvim"; }
    ];

  extraLazyImport = [
    "plugins.max.editor"
  ];
}
