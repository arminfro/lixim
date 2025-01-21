return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "jq" },
      },
    },
  },

  {
    "phelipetls/jsonpath.nvim",
    ft = { "json" },
    keys = {
      -- todo, set this key dynamically
      {
        "<leader>cY",
        function()
          vim.fn.setreg("+", require("jsonpath").get())
        end,
        desc = "Copy Jsonpath",
      },
    },
  },

  {
    "luckasRanarison/nvim-devdocs",
    optional = true,
    opts = { ensure_installed = { "jq" } },
  },
}
