self:
{
  pkgs,
  config,
  utils,
  ...
}:
{
  extraPackages = [ pkgs.tailwindcss-language-server ];

  plugins = [
    (utils.buildVimPlugin { name = "tailwindcss-colorizer-cmp.nvim"; })
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.tailwind"
  ];
}
