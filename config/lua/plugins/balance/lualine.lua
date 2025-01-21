return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        -- Show commit info at current line on cursorhold
        "f-person/git-blame.nvim",
        config = function()
          vim.g.gitblame_display_virtual_text = 0
          vim.g.gitblame_date_format = "%r"
          vim.g.gitblame_highlight_group = "Question"
          vim.g.gitblame_message_template = "<date> • <summary>"
        end,
      },
    },
    opts = function(_, opts)
      table.insert(opts.tabline.lualine_y, require("gitblame").get_current_blame_text)
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "meuter/lualine-so-fancy.nvim" },
    opts = function(_, opts)
      -- todo, remove current "recording @x"
      -- opts.sections.lualine_x = { "fancy_macro" }
      opts.sections.lualine_a = { { "fancy_mode", width = 3 } }
      table.insert(opts.tabline.lualine_a, {
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
      table.insert(opts.sections.lualine_x, { "fancy_searchcount" })
      table.insert(opts.sections.lualine_z, { "fancy_lsp_servers" })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "sherlock5512/lualine-spell-status" },
    opts = function(_, opts)
      table.insert(opts.sections.lualine_b, 1, {
        "spell_status",
      })
    end,
  },
}
