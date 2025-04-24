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
      table.insert(opts.tabline.lualine_x, {
        require("gitblame").get_current_blame_text,
        cond = function()
          return require("gitblame").get_current_blame_text() ~= nil
        end,
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "sherlock5512/lualine-spell-status" },
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, 3, {
        "spell_status",
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "stevearc/overseer.nvim" },
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        "overseer",
      })
    end,
  },
}
