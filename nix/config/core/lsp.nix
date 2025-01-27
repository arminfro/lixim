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
      lsp_lines-nvim
      actions-preview-nvim
    ]
    ++ utils.buildVimPlugins [
      {
        name = "output-panel.nvim";
      }
    ];

  extraPackages = [ pkgs.emmet-language-server ];

  extraLazyImport = [
    "plugins.core.lsp"
  ];
}
