self:
{
  pkgs,
  ...
}:
{
  extraPackages = [ pkgs.rustywind ];

  plugins = with pkgs.vimPlugins; [
    tailwind-tools-nvim
  ];

  extraLazyImport = [
    "plugins.core.lang.tailwind"
  ];
}
