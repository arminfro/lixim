self:
{
  pkgs,
  ...
}:
{
  plugins = [
    pkgs.vimPlugins.kulala-nvim
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (
      plugins: with plugins; [
        http
        graphql
      ]
    ))
  ];

  extraPackages = [
    pkgs.curl
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.util.rest"
  ];
}
