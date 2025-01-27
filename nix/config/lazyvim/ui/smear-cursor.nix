self:
{
  pkgs,
  utils,
  ...
}:
{
  plugins = [
    (utils.buildVimPlugin { name = "smear-cursor.nvim"; })
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.ui.smear-cursor"
  ];
}
