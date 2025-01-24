local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        vertical = {
          prompt_position = "top",
          width = 0.95,
          mirror = "flip",
        },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        -- "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--ignore",
        "--glob=!{.git,node_modules,vendor,package-lock.json,yarn.lock,data,**/*.tsx.snap}",
      },
      mappings = {
        i = {
          -- require("telescope.actions")
          ["<C-j>"] = function(...)
            return require("telescope.actions").move_selection_next(...)
          end,
          ["<C-k>"] = function(...)
            return require("telescope.actions").move_selection_previous(...)
          end,
          ["<ESC>"] = function(...)
            return require("telescope.actions").close(...)
          end,
          ["<C-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
          ["<C-n>"] = function(...)
            return require("telescope.actions").cycle_history_next(...)
          end,
          ["<C-p>"] = function(...)
            return require("telescope.actions").cycle_history_prev(...)
          end,
          ["<C-q>"] = function(...)
            return require("telescope.actions").smart_send_to_qflist(...)
              + require("telescope.actions").open_qflist(...)
          end,
          ["<CR>"] = function(...)
            return require("telescope.actions").select_default(...)
          end,
          ["<a-t>"] = function(...)
            return require("trouble.providers.telescope").open_selected_with_trouble(...)
          end,
          -- ["<a-i>"] = function()
          -- 	Util.telescope("find_files", { no_ignore = true })()
          -- end,
          -- ["<a-h>"] = function()
          -- 	Util.telescope("find_files", { hidden = true })()
          -- end,
          ["<C-Down>"] = function(...)
            return require("telescope.actions").cycle_history_next(...)
          end,
          ["<C-Up>"] = function(...)
            return require("telescope.actions").cycle_history_prev(...)
          end,
          ["<C-f>"] = function(...)
            return require("telescope.actions").preview_scrolling_down(...)
          end,
          ["<C-b>"] = function(...)
            return require("telescope.actions").preview_scrolling_up(...)
          end,
        },
        n = {
          ["<C-n>"] = function(...)
            return require("telescope.actions").move_selection_next(...)
          end,
          ["<C-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
          ["<C-p>"] = function(...)
            return require("telescope.actions").move_selection_previous(...)
          end,
          ["<C-q>"] = function(...)
            return require("telescope.actions").smart_send_to_qflist(...)
              + require("telescope.actions").open_qflist(...)
          end,
          ["<C-y"] = function(...)
            return require("telescope.actions").preview_scrolling_up(...)
          end,
          ["<C-e"] = function(...)
            return require("telescope.actions").preview_scrolling_down(...)
          end,
          ["q"] = function(...)
            return require("telescope.actions").close(...)
          end,
        },
      },
      file_ignore_patterns = {},
      path_display = { "relative" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      live_grep = {
        --@usage don't include the filename in the search results
        only_sort_text = true,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  },
  keys = {
    {
      "<leader>sf",
      function()
        require("telescope.builtin").grep_string({
          shorten_path = true,
          word_match = "-w",
          only_sort_text = true,
          search = "",
        })
      end,
      desc = "Fuzzy Grep ",
    },
  },
  dependencies = {
    -- {
    -- 	"otavioschwanck/telescope-alternate",
    -- 	config = function()
    -- 		require("telescope").load_extension("telescope-alternate")
    -- 		require("telescope-alternate").setup({
    -- 			pressets = { "angular" },
    -- 			mappings = {
    -- 				{
    -- 					"web/src/app/(.*)/(.*).ts",
    -- 					{
    -- 						{ "web/src/app/[1]/[2].spec.ts", "Test" },
    -- 					},
    -- 				},
    -- 				{
    -- 					"web/src/app/(.*)/(.*).spec.ts",
    -- 					{
    -- 						{ "web/src/app/[1]/[2].interceptor.ts", "Interceptor" },
    -- 						{ "web/src/app/[1]/[2].directive.ts", "Directive" },
    -- 						{ "web/src/app/[1]/[2].guard.ts", "Guard" },
    -- 						{ "web/src/app/[1]/[2].pipe.ts", "Pipe" },
    -- 						{ "web/src/app/[1]/[2].ts", "Class" },
    -- 					},
    -- 				},
    -- 				{
    -- 					"web/src/app/(.*)/(.*).component.(.*)",
    -- 					{
    -- 						{ "web/src/app/[1]/[2].module.ts", "Module" },
    -- 						{ "web/src/app/[1]/[2].component.ts", "Component" },
    -- 						{ "web/src/app/[1]/[2].service.ts", "Service" },
    -- 						{ "web/src/app/[1]/[2].component.html", "Template" },
    -- 						{ "web/src/app/[1]/[2].component.css", "Styles" },
    -- 						{ "web/src/app/[1]/[2].component.scss", "Styles" },
    -- 						{ "web/src/app/[1]/[2]-routing.module.ts", "Routing" },
    -- 					},
    -- 				},
    -- 				{
    -- 					"web/src/app/(.*)/(.*).service.ts",
    -- 					{
    -- 						{ "web/src/app/[1]/[2].module.ts", "Module" },
    -- 						{ "web/src/app/[1]/[2].component.ts", "Component" },
    -- 						{ "web/src/app/[1]/[2].component.html", "Template" },
    -- 						{ "web/src/app/[1]/[2].component.css", "Styles" },
    -- 						{ "web/src/app/[1]/[2].component.scss", "Styles" },
    -- 						{ "web/src/app/[1]/[2].component.spec.ts", "Test" },
    -- 						{ "web/src/app/[1]/[2]-routing.module.ts", "Routing" },
    -- 					},
    -- 				},
    -- 				{
    -- 					"web/src/app/(.*)/(.*).module.ts",
    -- 					{
    -- 						{ "web/src/app/[1]/[2].component.ts", "Component" },
    -- 						{ "web/src/app/[1]/[2].service.ts", "Service" },
    -- 						{ "web/src/app/[1]/[2].component.html", "Template" },
    -- 						{ "web/src/app/[1]/[2].component.css", "Styles" },
    -- 						{ "web/src/app/[1]/[2].component.scss", "Styles" },
    -- 						{ "web/src/app/[1]/[2].component.spec.ts", "Test" },
    -- 						{ "web/src/app/[1]/[2]-routing.module.ts", "Routing" },
    -- 					},
    -- 				},
    -- 			},
    -- 		})
    -- 	end,
    -- 	keys = {
    -- 		{
    -- 			"<leader>fa",
    -- 			"<cmd>Telescope telescope-alternate alternate_file<CR>",
    -- 			desc = "Find alternative file",
    -- 		},
    -- 	},
    -- },
    -- -- "danielvolchek/tailiscope.nvim"
    {
      "Snikimonkd/telescope-git-conflicts.nvim",
      config = function()
        require("telescope").load_extension("conflicts")
      end,
      keys = {
        { "<leader>gz", "<cmd>Telescope conflicts<CR>", desc = "Conflicts" },
      },
    },

    {
      "gbprod/yanky.nvim",
      event = "LazyFile",
      opts = {
        highlight = { timer = 150 },
      },
    },

    {
      "tsakirist/telescope-lazy.nvim",
      keys = {
        {
          "<leader>fp",
          function()
            require("telescope").extensions.lazy.lazy()
          end,
          desc = "Installed Plugins",
        },
      },
      config = function()
        require("telescope").load_extension("lazy")
      end,
    },

    {
      "nvim-telescope/telescope-node-modules.nvim",
      ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
      keys = {
        {
          "<leader>sn",
          function()
            require("telescope").extensions.node_modules.list()
          end,
          desc = "Node modules",
        },
      },
      config = function()
        require("telescope").load_extension("node_modules")
      end,
    },

    {
      "crispgm/telescope-heading.nvim",
      ft = { "markdown" },
      keys = {
        {
          "<leader>sH",
          function()
            require("telescope").extensions.heading.heading()
          end,
          desc = "Headlines",
        },
      },
      config = function()
        require("telescope").load_extension("heading")
      end,
    },

    {
      "LinArcX/telescope-env.nvim",
      keys = {
        {
          "<leader>se",
          function()
            require("telescope").extensions.env.env()
          end,
          desc = "Environment",
        },
      },
      config = function()
        require("telescope").load_extension("env")
      end,
    },

    {
      "benfowler/telescope-luasnip.nvim",
      keys = {
        {
          "<leader>sl",
          function()
            require("telescope").load_extension("luasnip")
            require("telescope").extensions.luasnip.luasnip()
          end,
          desc = "Snippets",
        },
      },
    },

    {
      "debugloop/telescope-undo.nvim",
      config = function()
        require("telescope").load_extension("undo")
        -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
      end,
      keys = {
        { "<leader>su", "<cmd>Telescope undo<CR>", desc = "Undo history" },
      },
    },

    {
      "MrcJkb/telescope-manix",
      ft = { "nix" },
      config = function()
        require("telescope").load_extension("manix")
        -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
      end,
      keys = {
        { "<leader>Dn", "<cmd>Telescope manix<CR>", desc = "Nix" },
      },
    },

    --
    -- {
    -- 	"lpoto/telescope-docker.nvim",
    -- 	keys = {
    -- 		{
    -- 			"<leader>tdn",
    -- 			function()
    -- 				require("telescope").extensions.docker.containers()
    -- 			end,
    -- 			desc = "Containers",
    -- 		},
    -- 		{
    -- 			"<leader>tdi",
    -- 			function()
    -- 				require("telescope").extensions.docker.images()
    -- 			end,
    -- 			desc = "Images",
    -- 		},
    -- 		{
    -- 			"<leader>tdn",
    -- 			function()
    -- 				require("telescope").extensions.docker.networks()
    -- 			end,
    -- 			desc = "Netowrks",
    -- 		},
    -- 		{
    -- 			"<leader>tdv",
    -- 			function()
    -- 				require("telescope").extensions.docker.volumes()
    -- 			end,
    -- 			desc = "Volumes",
    -- 		},
    -- 		{
    -- 			"<leader>tdo",
    -- 			function()
    -- 				require("telescope").extensions.docker.contexts()
    -- 			end,
    -- 			desc = "Contexts",
    -- 		},
    -- 		{
    -- 			"<leader>tds",
    -- 			function()
    -- 				require("telescope").extensions.docker.swarm()
    -- 			end,
    -- 			desc = "Swarm",
    -- 		},
    -- 		{
    -- 			"<leader>tdm",
    -- 			function()
    -- 				require("telescope").extensions.docker.machines()
    -- 			end,
    -- 			desc = "Machines",
    -- 		},
    -- 		{
    -- 			"<leader>tdc",
    -- 			function()
    -- 				require("telescope").extensions.docker.compose()
    -- 			end,
    -- 			desc = "Compose",
    -- 		},
    -- 		{
    -- 			"<leader>tdf",
    -- 			function()
    -- 				require("telescope").extensions.docker.files()
    -- 			end,
    -- 			desc = "Files",
    -- 		},
    -- 	},
    -- 	config = function()
    -- 		require("telescope").load_extension("docker")
    -- 	end,
    -- },

    {
      "nvim-telescope/telescope-symbols.nvim",
      opts = {},
      config = function() end,
      keys = {
        {
          "<leader>fo",
          "<cmd>Telescope symbols<CR>",
          desc = "Symbols & Emojis",
        },
      },
    },

    -- {
    -- 	"johmsalas/text-case.nvim",
    -- 	opts = {},
    -- 	keys = {
    -- 		{
    -- 			"<leader>cc",
    -- 			"<cmd>TextCaseOpenTelescope<CR>",
    -- 			desc = "Textcase",
    -- 		},
    -- 	},
    -- },
    --
    -- -- note, needs `ln -s ~/.zshrc ~/.zshenv`
    -- -- see, nvim-telescope/telescope-z.nvim/issues/14
    {
      "nvim-telescope/telescope-z.nvim",
      config = function()
        require("telescope").load_extension("z")
      end,
      keys = {
        {
          "<leader>fl",
          ":Telescope z<CR>",
          desc = "Find dir",
        },
      },
    },
    --
    -- {
    -- 	"princejoogie/dir-telescope.nvim",
    -- 	-- telescope.nvim is a required dependency
    -- 	config = function()
    -- 		require("dir-telescope").setup({
    -- 			-- these are the default options set
    -- 			hidden = true,
    -- 			no_ignore = false,
    -- 			show_preview = true,
    -- 		})
    -- 		require("telescope").load_extension("dir")
    -- 	end,
    -- 	keys = {
    -- 		{
    -- 			"<leader>fz",
    -- 			"<cmd>Telescope dir live_grep<CR>",
    -- 			desc = "zoom for grep",
    -- 		},
    -- 		{
    -- 			"<leader>fZ",
    -- 			"<cmd>Telescope dir find_files<CR>",
    -- 			desc = "zoom for file",
    -- 		},
    -- 	},
    -- },
    --
    -- {
    -- 	"catgoose/telescope-helpgrep.nvim",
    -- 	-- telescope.nvim is a required dependency
    -- 	config = function()
    -- 		require("telescope").load_extension("helpgrep")
    -- 	end,
    -- 	keys = {
    -- 		{
    -- 			"<leader>sx",
    -- 			"<cmd>Telescope helpgrep<CR>",
    -- 			desc = "Helpgrep",
    -- 		},
    -- 	},
    -- },
    --
    -- -- "olacin/telescope-cc.nvim", -- conventional_commits
    -- "folke/trouble.nvim",
  },
}
