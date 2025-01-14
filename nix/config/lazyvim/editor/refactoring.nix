self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    refactoring-nvim
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.editor.refactoring"
  ];
}
