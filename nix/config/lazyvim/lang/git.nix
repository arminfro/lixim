self:
{
  pkgs,
  config,
  ...
}:
{
  plugins = [
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

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.git"
  ];
}
