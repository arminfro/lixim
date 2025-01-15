self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    nvim-jqx
    template-string-nvim
    hl_match_area-nvim
    nvim-devdocs
    template-string-nvim
  ];

  extraLazyImport = [
    "plugins.balance.coding"
  ];
}
