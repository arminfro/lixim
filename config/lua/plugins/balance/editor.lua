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
