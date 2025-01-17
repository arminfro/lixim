self:
{
  pkgs,
  utils,
  ...
}:
{
  plugins = [
    (utils.buildVimPlugin { name = "mistake.nvim"; })
  ];

  extraLazyImport = [
    "plugins.max.writing"
  ];
}
