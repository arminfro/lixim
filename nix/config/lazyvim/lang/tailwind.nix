self:
{
  pkgs,
  config,
  ...
}:
{
  extraPackages = [ pkgs.tailwindcss-language-server ];

  plugins = [
    pkgs.vimPlugins.tailwindcss-colorizer-cmp-nvim
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.tailwind"
  ];
}
