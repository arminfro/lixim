self:
{
  pkgs,
  ...
}:
{
  extraPackages = [
    pkgs.bash-language-server
    # shellcheck included in bash-language-server
    # pkgs.shellcheck
  ];

  plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (
      plugins: with plugins; [
        git_config
        hyprlang
        fish
        rasi
        kitty
      ]
    ))
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.util.dot"
  ];
}
