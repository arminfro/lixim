return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
        superhtml = {},
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        html = { "htmlhint" },
      },
    },
  },

  {
    "luckasRanarison/nvim-devdocs",
    optional = true,
    opts = { ensure_installed = { "html" } },
  },
}
