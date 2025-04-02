return {
  {
    "gennaro-tedesco/nvim-jqx",
    cmd = { "JqxList", "JqxQuery" },
    ft = { "json", "yaml" },
  },

  {
    "axelvc/template-string.nvim",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    config = function()
      require("template-string").setup({
        filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        jsx_brackets = true, -- must add brackets to jsx attributes
        remove_template_string = false, -- remove backticks when there are no template string
      })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  -- {
  -- 	"m-demare/hlargs.nvim",
  -- 	dependencies = { "nvim-treesitter/nvim-treesitter", "rebelot/kanagawa.nvim" },
  -- 	config = function()
  -- 		require("hlargs").setup({
  -- 			color = require("kanagawa.colors").setup({ theme = "wave" }).palette.surimiOrange,
  -- 		})
  -- 	end,
  -- },

  {
    "rareitems/hl_match_area.nvim",
    event = "BufRead",
    opts = {},
    init = function()
      vim.api.nvim_set_hl(0, "MatchArea", { bg = "#292c3d" })
    end,
  },

  {
    -- Index, Fetch and Search devdocs.io
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    keys = {
      { "<leader>D", "", desc = "+docs" },
      { "<leader>Dd", "<cmd>DevdocsOpen<CR>", desc = "Devdocs" },
    },
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function(_, opts)
      require("tiny-inline-diagnostic").setup(opts)
      vim.diagnostic.config({ virtual_text = false })
    end,
    opts = {
      use_icons_from_diagnostic = true,
      show_all_diags_on_cursorline = true,
      show_source = true,
    },
  },

  -- {
  -- 	-- see `:h vim-arsync-configuration` for usage
  -- 	"kenn7/vim-arsync",
  -- 	dependencies = {
  -- 		{
  -- 			"prabirshrestha/async.vim",
  -- 			-- {
  -- 			-- 	"folke/which-key.nvim",
  -- 			-- 	optional = true,
  -- 			-- 	opts = {
  -- 			-- 		defaults = {
  -- 			-- 			["<leader>ta"] = { name = "+async rsync" },
  -- 			-- 		},
  -- 			-- 	},
  -- 			-- },
  -- 		},
  -- 	},
  -- 	keys = {
  -- 		{
  -- 			"<leader>tas",
  -- 			":ARshowConf<CR>",
  -- 			desc = "Show Configuration",
  -- 			mode = "n",
  -- 		},
  -- 		{
  -- 			"<leader>tau",
  -- 			":ARsyncUp<CR>",
  -- 			desc = "upload local to remote",
  -- 			mode = "n",
  -- 		},
  -- 		{
  -- 			"<leader>tad",
  -- 			":ARsyncDown<CR>",
  -- 			desc = "download remote to local",
  -- 			mode = "n",
  -- 		},
  -- 	},
  -- },
}
