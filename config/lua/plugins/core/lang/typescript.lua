return {

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        typescript = { "ts-standard" },
        typescriptreact = { "ts-standard" },
      },
    },
  },

  {
    "luckasRanarison/nvim-devdocs",
    optional = true,
    opts = { ensure_installed = { "typescript", "javascript", "dom", "eslint" } },
  },
}
