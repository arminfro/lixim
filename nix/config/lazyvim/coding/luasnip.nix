self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    { name = "LuaSnip"; path = luasnip; }
    friendly-snippets
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.coding.luasnip"
  ];
}
