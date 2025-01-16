return {
  {
    -- provides lsp features and a code completion source for code embedded in other documents
    "jmbuhr/otter.nvim",
    keys = {
      {
        "<leader>cy",
        ":lua require'otter'.activate({''})",
        desc = "Add embedded filetype LSP",
      },
    },
    dependencies = {
      "hrsh7th/nvim-cmp",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    -- display lsp hover documentation in a side panel.
    "amrbashir/nvim-docs-view",
    opts = {
      position = "bottom",
    },
    cmd = { "DocsViewToggle" },
    keys = {
      { "<leader>Dh", "<cmd>DocsViewToggle<CR>", desc = "LSP hover doc side panel" },
    },
  },

  -- {
  -- 	"ahmedkhalf/project.nvim",
  -- 	dependencies = "nvim-telescope/telescope.nvim", -- optional
  -- 	event = "BufWinEnter",
  -- 	config = function(_, opts)
  -- 		require("project_nvim").setup(opts)
  -- 		require("lazyvim.util").on_load("telescope.nvim", function()
  -- 			require("telescope").load_extension("projects")
  -- 		end)
  -- 	end,
  -- 	opts = {
  -- 		manual_mode = false,
  -- 		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile" },
  -- 		-- detection_methods = { "pattern" },
  -- 	},
  -- 	keys = {
  -- 		{ "<leader>o", ":Telescope projects<CR>", desc = "Open project" },
  -- 	},
  -- },

  -- sometimes triggers issues with autocmd's, try later again
  -- {
  -- 	-- plugin to maintain lines max length
  -- 	"fmbarina/multicolumn.nvim",
  -- 	opts = {
  -- 		sets = {
  -- 			lua = {
  -- 				scope = "file",
  -- 				rulers = { 121 },
  -- 				full_column = true,
  -- 			},
  -- 			NeogitCommitMessage = {
  -- 				scope = "window",
  -- 				rulers = { 51 },
  -- 				to_line_end = true,
  -- 				always_on = true,
  -- 			},
  -- 			gitcommit = {
  -- 				scope = "window",
  -- 				rulers = { 51 },
  -- 				to_line_end = true,
  -- 				always_on = true,
  -- 			},
  -- 		},
  -- 	},
  -- },

  -- -- todo, try later
  -- {
  -- 	"hoschi/yode-nvim", -- missing in NixNeovimPlugins
  -- 	lazy = true,
  -- 	keys = {
  -- 		{
  -- 			"<leader>up",
  -- 			":YodeCreateSeditorFloating<CR>",
  -- 			desc = "Pick a range and make it sticky",
  -- 			mode = "v",
  -- 		},
  -- 	},
  -- },
}
