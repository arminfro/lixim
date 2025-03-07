return {
  {
    "folke/snacks.nvim",
    opts = {
      ---@class snacks.picker.Config
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "i", "n" } },
            },
          },
        },
        layout = {
          layout = {
            backdrop = false,
            width = 0.95,
            min_width = 80,
            height = 0.9,
            min_height = 30,
            box = "vertical",
            border = "rounded",
            title = "{source} {live}",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
            { win = "preview", height = 0.6, border = "top" },
          },
        },
        ---@class snacks.picker.formatters.Config
        formatters = {
          file = {
            truncate = vim.o.columns * 1 / 3,
          },
        },
      },
    },
    init = function()
      vim.api.nvim_set_keymap("n", ",", ":lua Snacks.picker.buffers()<CR>", {
        desc = "Buffers",
      })
    end,
  },
}
