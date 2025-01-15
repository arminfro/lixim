return {
	{ -- todo, see if Snacks can provide it
		"andrewferrier/debugprint.nvim",
		cmd = "DeleteDebugPrints",
		event = "BufRead",
		config = true,
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

	{
		-- Shows virtual text of the current context after functions, methods, statements
		"haringsrob/nvim_context_vt",
		event = "BufRead",
	},
}
