self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    mini-files
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.editor.mini-files"
  ];
}
