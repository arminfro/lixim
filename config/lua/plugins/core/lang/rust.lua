vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = false,
          buildScripts = {
            enable = false,
            rebuildOnSave = false,
            targetDir = false,
          },
        },
      },
    },
  },
}

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
