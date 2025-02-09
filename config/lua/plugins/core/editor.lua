return {

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
      continue = false,
    },
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>uu", ":UndotreeToggle<CR>", desc = "Toggle undo tree" },
    },
  },

  {
    "chrisgrieser/nvim-scissors",
    cond = function()
      return vim.env.SNIPPETS_PATH ~= nil
    end,
    dependencies = "nvim-telescope/telescope.nvim",
    opts = function()
      local path = snippets_path()
      if path ~= nil then
        return {
          snippetDir = path,
        }
      end
    end,
    cmd = { "ScissorsEditSnippet", "ScissorsAddNewSnippet" },
    keys = {
      { "<leader>l", "", desc = "+snippets" },
      { "<leader>la", ":ScissorsAddNewSnippet<CR>", desc = "Add new snippet", mode = { "v", "n" } },
      { "<leader>le", ":ScissorsEditSnippet<CR>", desc = "Edit snippet", mode = { "n" } },
    },
  },

  {
    "yorickpeterse/nvim-window",
    config = function()
      require("nvim-window").setup({
        chars = {
          "h",
          "j",
          "k",
          "l",
          "a",
          "s",
          "d",
          "f",
        },
      })
    end,
    keys = {
      {
        "W",
        function()
          require("nvim-window").pick()
        end,
        desc = "Pick window to focus",
      },
    },
    event = "BufRead",
  },

  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    keys = {
      {
        "<leader>ci",
        function()
          require("ts-node-action").node_action()
        end,
        desc = "TS-node action",
      },
    },
    opts = {},
    config = function(_, opts)
      require("ts-node-action").setup(opts)
    end,
  },

  -- more than a dozen new text objects
  {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
      require("various-textobjs").setup({ keymaps = { useDefaults = true } })
      -- overwrite conflicts with default keymap
      vim.keymap.set({ "n", "v" }, "L", "g_", { noremap = true, silent = true, desc = "Jump to end of line" })
    end,
  },

  {
    "pbrisbin/vim-mkdir",
  },

  {
    "klen/nvim-config-local",
    opts = {},
  },

  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat", event = "VeryLazy" },

  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    config = true,
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open Oil" },
    },
    opts = {
      default_file_explorer = true,
      columns = {
        "size",
        "mtime",
        "icon",
      },
    },
  },

  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      zen = {},
      dim = {},
    },
    keys = {
      {
        "<leader>uz",
        function()
          Snacks.zen()
          Snacks.dim()
        end,
        desc = "ZenMode",
      },
      {
        "<leader>Z",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Toggle Zoom",
      },
    },
  },
}
