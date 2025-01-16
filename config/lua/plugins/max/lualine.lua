return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    dependencies = { "Isrothy/lualine-diagnostic-message" },
    opts = function(_, opts)
      local icons = LazyVim.config.icons
      table.insert(opts.sections.lualine_c, {
        "diagnostic-message",
        icons = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    dependencies = { "chrisgrieser/nvim-dr-lsp" },
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, {
        require("dr-lsp").lspCount,
        color = function()
          return { fg = Snacks.util.color("Statement") }
        end,
      })
    end,
  },
}
