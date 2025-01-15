return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options.disabled_filetypes.winbar = opts.options.disabled_filetypes.statusline
      opts.winbar = {
        lualine_a = {},
        lualine_b = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 },
          },
          { LazyVim.lualine.pretty_path({
            length = 0,
          }) },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }
      opts.inactive_winbar = opts.winbar
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      { "chrisgrieser/nvim-tinygit", optional = true, opts = {} },
    },
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        require("tinygit.statusline").branchState,
      })
    end,
  },
}
