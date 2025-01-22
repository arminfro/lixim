-- This file changes LazyVim default configs
return {
  -- set tsdk path for astro-ls
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        astro = {
          init_options = {
            typescript = {
              tsdk = LazyVim.get_pkg_path(
                "vtsls",
                "node_modules/typescript/lib/vtsls-language-server/node_modules/typescript/lib"
              ),
            },
          },
        },
      },
    },
  },

  -- disable bufferline in favor of lualine buffers feature
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  {
    "neovim/nvim-lspconfig",
    optional = true,
    keys = {
      { "<leader>ca", false },
    },
  },

  {
    "folke/noice.nvim",
    optional = true,
    keys = {
      { "<leader>sn", false },
      { "<leader>xn", "", desc = "+noice" },

      { "<leader>snl", false },
      {
        "<leader>xnl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },

      { "<leader>snh", false },
      {
        "<leader>xnh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },

      { "<leader>sna", false },
      {
        "<leader>xna",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },

      { "<leader>snd", false },
      {
        "<leader>xnd",
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All",
      },

      { "<leader>snt", false },
      {
        "<leader>xnt",
        function()
          require("noice").cmd("pick")
        end,
        desc = "Noice Picker (Telescope/FzfLua)",
      },
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    optional = true,
    keys = {
      {
        "<leader>sr",
        false,
      },
      {
        "<leader>sR",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      { "<leader>sR", false },
      { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume" },

      { "<leader><space>", false },

      { "<leader>gc", false },
      { "<leader>gs", false },
      { "<leader>gC", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gm", "<cmd>Telescope git_status<CR>", desc = "Modified" },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    keys = {
      { "<leader>e", false },
    },
  },

  {
    "catppuccin/nvim",
    optional = true,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
    },
  },
}
