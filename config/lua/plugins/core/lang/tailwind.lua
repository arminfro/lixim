return {
  {
    "luckasRanarison/tailwind-tools.nvim",
    build = ":UpdateRemotePlugins",
    event = "LazyFile",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      { "nvim-telescope/telescope.nvim", optional = true },
      { "neovim/nvim-lspconfig", optional = true },
    },
    opts = {},
    config = function(_, opts)
      require("tailwind-tools").setup(opts)
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescriptreact = { "rustywind" },
      },
    },
  },

  {
    "luckasRanarison/nvim-devdocs",
    optional = true,
    opts = { ensure_installed = { "tailwindcss" } },
  },
}
