self:
{
  pkgs,
  config,
  ...
}:
{
  extraPackages = with pkgs; [
    sqlfluff
  ];

  plugins = with pkgs.vimPlugins; [
    vim-dadbod
    vim-dadbod-completion
    vim-dadbod-ui
    (nvim-treesitter.withPlugins (plugins: [
      plugins.sql
    ]))
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.sql"
  ];
}
