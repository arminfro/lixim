return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        stylelint_lsp = {},
      },
    },
  },

  {
    "luckasRanarison/nvim-devdocs",
    optional = true,
    opts = { ensure_installed = { "css", "sass" } },
  },
}
