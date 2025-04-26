return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        kulala = {
          command = "kulala-fmt",
          args = { "format", "$FILENAME" },
          stdin = false,
        },
      },
      formatters_by_ft = {
        http = { "kulala" },
      },
    },
  },
}
