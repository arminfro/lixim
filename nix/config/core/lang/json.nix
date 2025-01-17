self:
{
  pkgs,
  config,
  lib,
  utils,
  ...
}:
{
  plugins = [
    {
      name = "jsonpath.nvim";
      path = utils.buildVimPlugin {
        name = "jsonpath-nvim";
        nvimSkipModule = [ "jsonpath" ];
      };
    }
  ];

  extraLazyImport = [
    "plugins.core.lang.json"
  ];
}
