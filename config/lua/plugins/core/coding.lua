return {
  {
    "andrewferrier/debugprint.nvim",
    cmd = "DeleteDebugPrints",
    event = "LazyFile",
    config = true,
  },

  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local path = snippets_path()
      if path ~= nil then
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { path } })
      end
    end,
  },

  {
    -- Shows virtual text of the current context after functions, methods, statements
    "haringsrob/nvim_context_vt",
    event = "LazyFile",
  },

  {
    "mawkler/refjump.nvim",
    keys = { "]r", "[r" },
    opts = {},
  },

  -- {
  -- 	"HiPhish/rainbow-delimiters.nvim",
  -- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
  -- 	config = function()
  -- 		local rainbow_delimiters = require("rainbow-delimiters")
  --
  -- 		vim.g.rainbow_delimiters = {
  -- 			strategy = {
  -- 				[""] = rainbow_delimiters.strategy["global"],
  -- 				vim = rainbow_delimiters.strategy["local"],
  -- 			},
  -- 			query = {
  -- 				[""] = "rainbow-delimiters",
  -- 				lua = "rainbow-blocks",
  -- 			},
  -- 			highlight = {
  -- 				"RainbowDelimiterRed",
  -- 				"RainbowDelimiterYellow",
  -- 				"RainbowDelimiterBlue",
  -- 				"RainbowDelimiterOrange",
  -- 				"RainbowDelimiterGreen",
  -- 				"RainbowDelimiterViolet",
  -- 				"RainbowDelimiterCyan",
  -- 			},
  -- 		}
  -- 	end,
  -- },
}
