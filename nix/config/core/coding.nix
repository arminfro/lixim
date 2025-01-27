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
      nvim_context_vt
      debugprint-nvim
    ]
    ++ utils.buildVimPlugins [
      {
        name = "refjump.nvim";
      }
    ];

  extraLazyImport = [
    "plugins.core.coding"
  ];
}
