self:
{
  pkgs,
  config,
  utils,
  ...
}:
{
  extraPackages = with pkgs; [
    basedpyright
    ruff
  ];

  plugins =
    with pkgs.vimPlugins;
    [
      neotest-python
      nvim-dap
      nvim-dap-python
      neotest
      neotest-python
      (nvim-treesitter.withPlugins (plugins: [
        plugins.ninja
        plugins.rst
      ]))
    ]
    ++ [
      (utils.buildVimPlugin { name = "venv-selector.nvim"; })
    ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.python"
  ];

  extraLuaConfig = [
    # lua
    ''
      vim.g.lazyvim_python_lsp = "basedpyright"
    ''
  ];
}
