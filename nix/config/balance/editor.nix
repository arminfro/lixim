self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    compiler-nvim
    overseer-nvim
    zen-mode-nvim
    twilight-nvim
    fsread-nvim
    nvim-fundo
    promise-async
    hand-side-fix-nvim
  ];

  extraLazyImport = [
    "plugins.balance.editor"
  ];
}
