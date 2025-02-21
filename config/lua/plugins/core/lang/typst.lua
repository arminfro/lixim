return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {},
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typst = { "typstyle" },
      },
    },
  },
}
