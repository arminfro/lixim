self:
{
  pkgs,
  config,
  ...
}:
{
  extraPackages =
    with pkgs;
    [
      cargo
      clippy
      rust-analyzer
      bacon
      vscode-extensions.vadimcn.vscode-lldb
    ]
    ++ [
      self.inputs.bacon-ls.defaultPackage.${pkgs.system}
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

  extraLuaConfig = # lua
    [
      ''
        vim.g.lazyvim_rust_diagnostics = "bacon-ls"
      ''
    ];
}
