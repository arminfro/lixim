self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    aerial-nvim
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.editor.aerial"
  ];
}
