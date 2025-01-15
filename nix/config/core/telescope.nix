self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    telescope-alternate
    telescope-env-nvim
    telescope-git-conflicts-nvim
    telescope-heading-nvim
    telescope-lazy-nvim
    telescope-luasnip-nvim
    telescope-manix
    telescope-node-modules-nvim
    telescope-symbols-nvim
    telescope-undo-nvim
    telescope-z-nvim
  ];

  extraLazyImport = [
    "plugins.core.telescope"
  ];
}
