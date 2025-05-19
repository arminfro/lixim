return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        just = { "just" },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {},
    ---@class PluginLspOpts
    opts = {
      servers = {
        just = {},
      },
    },
  },
}
