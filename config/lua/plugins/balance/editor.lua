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
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        biome = {},
      },
    },
  },

  {
    "stevearc/overseer.nvim",
    keys = {
      {
        "<leader>or",
        function()
          local overseer = require("overseer")
          local tasks = overseer.list_tasks({ recent_first = true })
          if vim.tbl_isempty(tasks) then
            vim.notify("No tasks found", vim.log.levels.WARN)
          else
            save_all_modifed_buffers()
            overseer.run_action(tasks[1], "restart")
          end
        end,
        desc = "Repeat last task",
      },
    },
  },

  {
    "kevinhwang91/nvim-fundo",
    event = "LazyFile",
    dependencies = "kevinhwang91/promise-async",
    build = function()
      require("fundo").install()
    end,
    opts = {},
  },

  {
    "arminfro/hand-side-fix.nvim",
    event = "LazyFile",
    opts = {
      layout = "us",
    },
  },
}
