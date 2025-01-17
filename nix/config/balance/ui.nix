self:
{
  pkgs,
utils,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    nvim-hlslens
    urlview-nvim
  ] ++ utils.buildVimPlugins [
    { name = "nvim-origami"; }
    ];

  extraLazyImport = [
    "plugins.balance.ui"
  ];
}
