self:
{
  pkgs,
  config,
  ...
}:
{
  extraPackages = with pkgs; [
    cargo
    rust-analyzer
  ];

  plugins = with pkgs.vimPlugins; [
    crates-nvim
    rustaceanvim
    (nvim-treesitter.withPlugins (plugins: [
      plugins.rust
      plugins.ron
    ]))
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.rust"
  ];
}
