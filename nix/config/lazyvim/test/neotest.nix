self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    neotest nvim-nio
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.test.core"
  ];
}

