self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    blink-compat
    blink-ripgrep-nvim
    # blink-cmp-dictionary
    cmp-conventionalcommits
    cmp-digraphs
    cmp-pandoc-references
    cmp-git
    cmp-calc
    cmp-emoji
    cmp-cmdline-history
  ];

  extraLazyImport = [
    "plugins.core.blink"
  ];
}
