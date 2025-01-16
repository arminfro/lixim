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

  extraPackages = with pkgs; [
    glow
    pandoc
    pandoc-lua-filters
    texliveBasic
  ];

  extraLazyImport = [
    "plugins.core.writing"
  ];
}
