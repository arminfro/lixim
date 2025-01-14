self:
{
  pkgs,
  config,
  ...
}:
let
  enable = config.lang.git.enable;
  emptyListOr = list: if enable then list else [ ];
in
{
  plugins = emptyListOr [
    pkgs.vimPlugins.cmp-git
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (
      plugins: with plugins; [
        git_config
        gitcommit
        git_rebase
        gitignore
        gitattributes
      ]
    ))
  ];

  extraLazyImport = emptyListOr [
    "lazyvim.plugins.extras.lang.git"
  ];
}
