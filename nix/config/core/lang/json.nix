self:
{
  pkgs,
  config,
  lib,
  utils,
  ...
}:
{
  extraPackages = with pkgs; [
    jq
  ];

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
