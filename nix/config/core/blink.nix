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
      blink-cmp-conventional-commits
      blink-cmp-dictionary
      # blink-cmp-git
      blink-compat
      blink-emoji-nvim
      blink-ripgrep-nvim
      cmp-calc
    ]
    ++ utils.buildVimPlugins [
      # { name = "cmp-pandoc-references"; }
    ];

  extraPackages = with pkgs; [
    wordnet
  ];

  extraLazyImport = [
    "plugins.core.blink"
  ];
}
