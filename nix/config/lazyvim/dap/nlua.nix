self:
{
  pkgs,
  ...
}:
{
  plugins = [
    pkgs.vimPlugins.one-small-step-for-vimkind
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.dap.nlua"
  ];
}
