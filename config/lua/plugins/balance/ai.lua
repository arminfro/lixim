-- prefil edit window with common scenarios to avoid repeating query and submit immediately
local prefill_edit_window = function(request)
  require("avante.api").edit()
  local code_bufnr = vim.api.nvim_get_current_buf()
  local code_winid = vim.api.nvim_get_current_win()
  if code_bufnr == nil or code_winid == nil then
    return
  end
  vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
  -- Optionally set the cursor position to the end of the input
  vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
  -- Simulate Ctrl+S keypress to submit
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
end

local avante_grammar_correction = "Correct the text to standard English, but keep any code blocks inside intact."
-- local avante_keywords = 'Extract the main keywords from the following text'
local avante_code_readability_analysis = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]
local avante_optimize_code = "Optimize the following code"
local avante_summarize = "Summarize the following text"
local avante_explain_code = "Explain the following code"
local avante_complete_code = function()
  return "Complete the following codes written in " .. vim.bo.filetype
end
local avante_add_docstring = "Add docstring to the following codes"
local avante_fix_bugs = "Fix the bugs inside the following codes if any"
local avante_add_tests = "Implement tests for the following code"

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    opts = function()
      local is_open_api_key_cmd_defined = vim.env.OPENAI_API_KEY_CMD ~= nil
      local is_open_api_key_defined = is_open_api_key_cmd_defined or vim.env.OPENAI_API_KEY ~= nil

      local opts = {
        provider = is_open_api_key_defined and "openai" or "ollama",
        openai = {},
        vendors = {
          ollama = {
            __inherited_from = "openai",
            api_key_name = "",
            endpoint = "http://127.0.0.1:11434/api",
            model = "qwen2.5-coder:0.5b",
          },
        },
        behaviour = {
          auto_suggestions = false,
        },
      }

      if is_open_api_key_cmd_defined then
        opts.openai.api_key_name = "cmd:" .. vim.env.OPENAI_API_KEY_CMD
      end

      return opts
    end,
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>ap",
        function()
          vim.ui.select({
            "openai",
            "ollama",
            "claude",
            "azure",
            "gemini",
            "cohere",
            "copilot",
          }, {
            prompt = "Choose Provider",
            telescope = require("telescope.themes").get_cursor(),
          }, function(selected)
            if selected then
              require("avante.api").switch_provider(selected)
            end
          end)
        end,
        -- "<CMD>AvanteSwitchProvider ",
        desc = "Switch Provider",
        mode = { "n" },
      },
      {
        "<leader>ag",
        function()
          require("avante.api").ask({ question = avante_grammar_correction })
        end,
        desc = "Grammar Correction(ask)",
        mode = { "n", "v" },
      },
      {
        "<leader>al",
        function()
          require("avante.api").ask({ question = avante_code_readability_analysis })
        end,
        desc = "Code Readability Analysis(ask)",
        mode = { "n", "v" },
      },
      {
        "<leader>ao",
        function()
          require("avante.api").ask({ question = avante_optimize_code })
        end,
        desc = "Optimize Code(ask)",
        mode = { "n", "v" },
      },
      {
        "<leader>am",
        function()
          require("avante.api").ask({ question = avante_summarize })
        end,
        desc = "Summarize text(ask)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          require("avante.api").ask({ question = avante_explain_code })
        end,
        desc = "Explain Code(ask)",
        mode = { "n", "v" },
      },
      {
        "<leader>ac",
        function()
          require("avante.api").ask({ question = avante_complete_code() })
        end,
        desc = "Complete Code(ask)",
        mode = { "n", "v" },
      },
      {
        "<leader>ad",
        function()
          require("avante.api").ask({ question = avante_add_docstring })
        end,
        desc = "Docstring(ask)",
        mode = { "n", "v" },
      },
      {
        "<leader>ab",
        function()
          require("avante.api").ask({ question = avante_fix_bugs })
        end,
        desc = "Fix Bugs(ask)",
        mode = { "n", "v" },
      },
      {
        "<leader>au",
        function()
          require("avante.api").ask({ question = avante_add_tests })
        end,
        desc = "Add Tests(ask)",
        mode = { "n", "v" },
      },

      {
        "<leader>aG",
        function()
          prefill_edit_window(avante_grammar_correction)
        end,
        desc = "Grammar Correction",
        mode = { "v" },
      },
      {
        "<leader>aO",
        function()
          prefill_edit_window(avante_optimize_code)
        end,
        desc = "Optimize Code(edit)",
        mode = { "v" },
      },
      {
        "<leader>aC",
        function()
          prefill_edit_window(avante_complete_code())
        end,
        desc = "Complete Code(edit)",
        mode = { "v" },
      },
      {
        "<leader>aD",
        function()
          prefill_edit_window(avante_add_docstring)
        end,
        desc = "Docstring(edit)",
        mode = { "v" },
      },
      {
        "<leader>aB",
        function()
          prefill_edit_window(avante_fix_bugs)
        end,
        desc = "Fix Bugs(edit)",
        mode = { "v" },
      },
      {
        "<leader>aU",
        function()
          prefill_edit_window(avante_add_tests)
        end,
        desc = "Add Tests(edit)",
        mode = { "v" },
      },
    },
    dependencies = {
      "HakonHarnes/img-clip.nvim",
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
