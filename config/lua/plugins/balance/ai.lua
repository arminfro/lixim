return {
  {
    "olimorris/codecompanion.nvim",
    config = true,
    opts = {
      strategies = {
        chat = {
          adapter = "local_ollama",
        },
        inline = {
          adapter = "local_ollama",
        },
        cmd = {
          adapter = "local_ollama",
        },
      },
      adapters = {
        openai = function()
          if vim.env.OPENAI_API_KEY_CMD ~= nil or vim.env.OPENAI_API_KEY ~= nil then
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = vim.env.OPENAI_API_KEY or ("cmd:" .. vim.env.OPENAI_API_KEY_CMD),
              },
            })
          end
        end,
        local_ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "local_ollama", -- Give this adapter a different name to differentiate it from the default ollama adapter
            schema = {
              model = {
                default = "gemma3:4b",
              },
            },
          })
        end,
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      -- {
      --   actions = <function 1>,
      --   add = <function 2>,
      --   buf_get_chat = <function 3>,
      --   chat = <function 4>,
      --   close_last_chat = <function 5>,
      --   cmd = <function 6>,
      --   inline = <function 7>,
      --   last_chat = <function 8>,
      --   prompt = <function 9>,
      --   prompt_library = <function 10>,
      --   setup = <function 11>,
      --   toggle = <function 12>,
      --   workspace_schema = <function 13>
      -- }
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>ac",
        "<CMD>CodeCompanionChat<CR>",
        desc = "chat",
        mode = { "n" },
      },
      {
        "<leader>aw",
        "<CMD>CodeCompanion /cw<CR>",
        desc = "code workflow",
        mode = { "n" },
      },
      {
        "<leader>at",
        "<CMD>CodeCompanion /et<CR>",
        desc = "edit<->test workflow",
        mode = { "n" },
      },
      {
        "<leader>ae",
        "<CMD>CodeCompanion /explain<CR>",
        desc = "explain",
        mode = { "v" },
      },
      {
        "<leader>au",
        "<CMD>CodeCompanion /tests<CR>",
        desc = "unit tests",
        mode = { "v" },
      },
      {
        "<leader>af",
        "<CMD>CodeCompanion /fix<CR>",
        desc = "Fix code",
        mode = { "v" },
      },
      {
        "<leader>al",
        "<CMD>CodeCompanion /lsp<CR>",
        desc = "explain lsp diagnostics",
        mode = { "v", "n" },
      },
      {
        "<leader>am",
        "<CMD>CodeCompanion /commit<CR>",
        desc = "generate commit msg",
        mode = { "n" },
      },
      {
        "<leader>aw",
        "<CMD>CodeCompanion /workspace<CR>",
        desc = "workspace file",
        mode = { "v", "n" },
      },
    },
  },
}
