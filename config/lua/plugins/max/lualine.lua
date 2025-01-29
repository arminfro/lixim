return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "chrisgrieser/nvim-dr-lsp" },
    opts = function(_, opts)
      table.insert(opts.sections.lualine_y, {
        require("dr-lsp").lspCount,
        color = function()
          return { fg = Snacks.util.color("Statement") }
        end,
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = function(_, opts)
      local lsp_info = {
        ["textDocument/hover"] = "",
      }

      ---@param value string
      ---@return string
      local function processHoverValue(value)
        local codeRegex = vim.regex("^```")
        local ruleRegex = vim.regex("^---")
        local result = ""
        for _, contentLine in ipairs(vim.split(value, "\n", { trimempty = true })) do
          if contentLine ~= "" and not codeRegex:match_str(contentLine) and not ruleRegex:match_str(contentLine) then
            -- trim whitespace and append
            result = result .. " " .. contentLine:gsub("^%s*(.-)%s*$", "%1")
          end
        end
        return result
      end

      -- inspired from github.com/Mr-LLLLL/lualine-ext.nvim
      local function processLspHover(hover)
        local readers = {
          {
            condition = function()
              return type(hover.contents) == "string"
            end,
            read = function()
              return hover.contents
            end,
          },
          {
            condition = function()
              return hover.contents.language
            end,
            read = function(contents)
              return contents.value
            end,
          },
          {
            condition = vim.islist,
            read = function()
              if vim.tbl_isempty(hover.contents) then
                return
              end
              local values = vim.tbl_map(function(ms)
                return type(ms) == "string" and ms or ms.value
              end, hover.contents)
              return table.concat(values, "\n")
            end,
          },
          {
            condition = function()
              return hover.contents.kind
            end,
            read = function()
              return hover.contents.value
            end,
          },
        }

        local value
        for _, reader in ipairs(readers) do
          if reader.condition() then
            value = reader.read()
            break
          end
        end

        if not value or #value == 0 then
          return
        end

        lsp_info["textDocument/hover"] = processHoverValue(value)
      end

      local function requestLspInfo(method)
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if vim.islist(clients) and #clients > 0 then
          for _, client in ipairs(clients) do
            if client.supports_method(method) then
              local lspParam = vim.lsp.util.make_position_params(0)
              vim.tbl_deep_extend("force", lspParam, { context = { includeDeclaration = false } })
              vim.lsp.buf_request(0, method, lspParam, function(err, result, _)
                if not err and result then
                  processLspHover(result)
                end
              end)
            else
            end
          end
        end
      end

      vim.api.nvim_create_autocmd({ "CursorHold" }, {
        pattern = { "*.*" },
        callback = function()
          lsp_info["textDocument/hover"] = ""
          requestLspInfo("textDocument/hover")
        end,
        group = vim.api.nvim_create_augroup("LualineLspHover", { clear = true }),
      })

      table.insert(opts.sections.lualine_y, 1, {
        function()
          local hover_info = lsp_info["textDocument/hover"]
          local max_length = vim.o.columns * 1 / 3
          if #hover_info >= max_length then
            return hover_info:sub(1, max_length) .. "..."
          end
          return hover_info
        end,
        cond = function()
          return lsp_info["textDocument/hover"] ~= ""
        end,
      })
    end,
  },
}
