self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    dial-nvim
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.editor.dial"
  ];
}
