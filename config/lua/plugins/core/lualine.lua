local icons = LazyVim.config.icons
local file_count_condition_gt = function(buffers_length)
  return function()
    return listed_buffers_length() > buffers_length
  end
end
local fileRef = {
  {
    "filetype",
    icon_only = true,
    separator = "",
    padding = { left = 0, right = 0 },
    cond = file_count_condition_gt(0),
  },
  { LazyVim.lualine.pretty_path({ length = 0 }), cond = file_count_condition_gt(0) },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
      -- opts.options.disabled_filetypes.tabline = opts.options.disabled_filetypes.statusline

      opts.winbar = opts.winbar or {}
      opts.winbar.lualine_b = fileRef
      opts.inactive_winbar = opts.active_winbar or {}
      opts.inactive_winbar.lualine_b = fileRef

      opts.tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "buffers",
            buffers_color = {
              active = { fg = Snacks.util.color("Special") },
            },
            cond = file_count_condition_gt(1),
          },
        },
        lualine_x = {},
        lualine_y = {
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_z = {},
      }
      -- opts.inactive_tabline = opts.tabline
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      { "chrisgrieser/nvim-tinygit", event = "LazyFile", optional = true, opts = {} },
    },
    opts = function(_, opts)
      table.insert(opts.tabline.lualine_y, {
        require("tinygit.statusline").branchState,
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      { "mfussenegger/nvim-lint", optional = true },
    },
    opts = function(_, opts)
      table.insert(opts.sections.lualine_z, {
        function()
          local linters = require("lint").linters_by_ft[vim.bo.filetype] or {}
          return table.concat(linters, " ")
        end,
        icon = "",
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      { "stevearc/conform.nvim", optional = true },
    },
    opts = function(_, opts)
      table.insert(opts.sections.lualine_z, {
        function()
          local formatters = require("conform").list_formatters_for_buffer()
          return table.concat(formatters, " ")
        end,
        icon = "󰉿",
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "meuter/lualine-so-fancy.nvim" },
    opts = function(_, opts)
      table.insert(opts.sections.lualine_a, { "fancy_mode", width = 3 })
      table.insert(opts.sections.lualine_x, { "fancy_macro" })
      table.insert(opts.sections.lualine_x, { "fancy_searchcount" })
      table.insert(opts.sections.lualine_z, 1, { "fancy_lsp_servers" })

      table.insert(opts.tabline.lualine_z, {
        "fancy_branch",
        fmt = function(str)
          return str:sub(1, 16)
        end,
      })
      table.insert(opts.tabline.lualine_b, 1, {
        "fancy_cwd",
        fmt = function(str)
          return extractLastPathSegments(str, 3)
        end,
      })
    end,
  },
}
