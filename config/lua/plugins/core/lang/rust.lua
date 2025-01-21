return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        rust = { "clippy" },
      },
    },
  },

  {
    "luckasRanarison/nvim-devdocs",
    optional = true,
    opts = { ensure_installed = { "rust" } },
  },
}
