self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    nvim_context_vt
    debugprint-nvim
  ];

  extraLazyImport = [
    "plugins.core.coding"
  ];
}
