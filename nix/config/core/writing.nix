self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    img-clip-nvim
    glow-nvim
    markdowny-nvim
    auto-pandoc-nvim
    nvim-toc
    mdeval-nvim
  ];

  extraLazyImport = [
    "plugins.core.writing"
  ];
}
