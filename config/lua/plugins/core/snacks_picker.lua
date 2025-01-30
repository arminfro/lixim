return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
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
      },
    },
    init = function()
      vim.api.nvim_set_keymap("n", ",", ":lua Snacks.picker.buffers()<CR>", {
        desc = "Buffers",
      })
    end,
  },
}
