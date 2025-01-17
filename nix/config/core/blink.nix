self:
{
  pkgs,
  utils,
  ...
}:
{
  plugins =
    with pkgs.vimPlugins;
    [
      blink-compat
      blink-ripgrep-nvim
      cmp-conventionalcommits
      cmp-digraphs
      cmp-pandoc-references
      cmp-git
      cmp-calc
      cmp-emoji
      cmp-cmdline-history
    ]
    ++ utils.buildVimPlugins [
      # {
      #   name = "blink-cmp-dictionary";
      #   nvimSkipModule = "blink-cmp-dictionary";
      # }

    ];

  extraLazyImport = [
    "plugins.core.blink"
  ];
}
