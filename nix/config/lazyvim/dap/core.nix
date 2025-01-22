self:
{
  pkgs,
  lib,
  config,
  ...
}:
{
  plugins =
    with pkgs.vimPlugins;
    [
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-nio
    ]
    ++ lib.optional config.lang.typescript.enable pkgs.vscode-js-debug;

  extraLazyImport = [
    "lazyvim.plugins.extras.dap.core"
  ];

  # todo, testing needed:
  extraMasonPath = lib.optional config.lang.typescript.enable {
    name = "packages/js-debug-adapter";
    path = pkgs.vscode-js-debug;
  };
}
