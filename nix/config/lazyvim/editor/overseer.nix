self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    overseer-nvim
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.editor.overseer"
  ];
}
