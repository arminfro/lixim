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
      compiler-nvim
      overseer-nvim
    ]
    ++ utils.buildVimPlugins [
      { name = "fsread.nvim"; }
      {
        name = "nvim-fundo";
        nvimSkipModule = [
          "fundo.fs.init"
          "fundo.fs.uvwrapper"
          "fundo.lib.mutex"
          "fundo.lib.semaphore"
          "fundo.main"
          "fundo.manager"
          "fundo.model.undo"
        ];
      }
      { name = "promise-async"; }
      { name = "hand-side-fix.nvim"; }
    ];

  extraLazyImport = [
    "plugins.balance.editor"
  ];
}
