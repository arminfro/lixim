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
      telescope-git-conflicts-nvim
      telescope-manix
      telescope-symbols-nvim
      telescope-undo-nvim
      telescope-z-nvim
    ]
    ++ utils.buildVimPlugins [
      {
        name = "telescope-alternate";
        nvimSkipModule = "telescope-alternate.telescope";
      }
      {
        name = "telescope-heading.nvim";
      }
      {
        name = "telescope-lazy.nvim";
      }
      {
        name = "telescope-node-modules.nvim";
      }
      {
        name = "telescope-env.nvim";
      }
    ];

  extraPackages = [
    pkgs.manix
  ];

  extraLazyImport = [
    "plugins.core.telescope"
  ];
}
