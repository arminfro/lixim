return {
  {
    "kevinhwang91/nvim-hlslens",
    event = "LazyFile",
    config = function()
      local ok, scrollbar_search_handler = pcall(require, "scrollbar.handlers.search")
      if ok and scrollbar_search_handler ~= nil then
        scrollbar_search_handler.setup({})
      end
    end,
    version = "v1.*",
    dependencies = { {
      { "petertriho/nvim-scrollbar", optional = true },
    } },
  },

  {
    "axieax/urlview.nvim",
    opts = {
      default_picker = "telescope",
    },
    keys = {
      {
        "<leader>sU",
        ":UrlView buffer<CR>",
        desc = "Urls in buffer",
      },
    },
  },

  { -- QoL features for folding
    "chrisgrieser/nvim-origami",
    event = "LazyFile",
    opts = {
      foldKeymaps = {
        hOnlyOpensOnFirstColumn = true,
      },
    },
  },
}
