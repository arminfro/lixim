self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    one-small-step-for-vimkind
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.dap.nlua"
  ];
}
