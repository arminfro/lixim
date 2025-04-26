self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs; [
    kulala-fmt
    vimPlugins.kulala-nvim
    (vimPlugins.nvim-treesitter.withPlugins (
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
