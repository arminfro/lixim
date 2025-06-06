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

  {
    "chomosuke/typst-preview.nvim",
    ft = { "typst" },
    cmd = { "TypstPreview" },
    opts = {
      dependencies_bin = {
        ["tinymist"] = vim.fn.exepath("tinymist"),
        ["websocat"] = vim.fn.exepath("websocat"),
      },
    },
  },
}
