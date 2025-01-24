return {
  -- {
  -- 	"NvChad/nvim-colorizer.lua",
  -- 	config = true,
  -- },

  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    keys = {
      { "<leader>X", "", desc = "+exec" },
      { "<leader>Xc", "<cmd>CompilerOpen<cr>", desc = "Compiler" },
      { "<leader>Xr", "<cmd>CompilerToggleResults<cr>", desc = "Toggle compiler results" },
    },
    opts = {},
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = {
        -- twilight = { enabled = false },
      },
    },
    keys = {
      { "<leader>uz", "<cmd>ZenMode<CR>", desc = "ZenMode" },
    },
  },

  {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        -- alpha = 0.75,
      },
      -- context = 0,
    },
    keys = {
      { "<leader>ut", "<cmd>Twilight<CR>", desc = "Twilight" },
    },
  },

  {
    "kevinhwang91/nvim-fundo",
    dependencies = "kevinhwang91/promise-async",
    build = function()
      require("fundo").install()
    end,
    opts = {},
  },

  {
    "arminfro/hand-side-fix.nvim",
    event = "BufEnter",
    opts = {
      layout = "us",
    },
  },
}
