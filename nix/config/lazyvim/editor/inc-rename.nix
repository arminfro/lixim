self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    inc-rename-nvim
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.editor.inc-rename"
  ];
}
