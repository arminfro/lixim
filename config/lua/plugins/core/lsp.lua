return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {},
    ---@class PluginLspOpts
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                maxPreload = 1000,
              },
              telemetry = { enable = false },
            },
          },
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {},
    ---@class PluginLspOpts
    opts = {
      servers = {
        emmet_language_server = {},
      },
    },
  },

  {
    "Maan2003/lsp_lines.nvim",
    event = "LazyFile",
    config = function()
      vim.diagnostic.config({
        virtual_lines = false,
      })
      require("lsp_lines").setup()
    end,
    keys = {
      {
        "<leader>uv",
        function()
          require("lsp_lines").toggle()
          local is_virtual_text = vim.diagnostic.config().virtual_text
          vim.diagnostic.config({
            virtual_text = not is_virtual_text,
          })
        end,
        desc = "Toggle Diagnostics multiline",
      },
    },
  },

  {
    -- preview code with code actions applied
    "aznhe21/actions-preview.nvim",
    event = "LazyFile",
    config = function()
      require("actions-preview").setup({
        telescope = {
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = "top",
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 15
            end,
          },
        },
      })
    end,
    keys = {
      {
        "<leader>ca",
        function()
          require("actions-preview").code_actions()
        end,
        desc = "Code Action",
        mode = { "n", "v" },
      },
    },
  },
}
