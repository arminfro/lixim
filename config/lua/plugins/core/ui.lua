return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        signature = { enabled = false },
      },
      popupmenu = {
        backend = "cmp",
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    keys = {
      {
        "<leader>xN",
        function()
          require("telescope").extensions.noice.noice()
        end,
        desc = "Noice Histroy",
      },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          -- {
          -- 	section = "terminal",
          -- 	-- todo, src picture within repo
          -- 	cmd = "chafa /home/armin/Downloads/nix-snowflake-colours.png --size 24x24 --format symbols --symbols vhalf; sleep .1",
          -- 	height = 8,
          -- 	padding = 1,
          -- 	align = "center",
          -- },
          -- {
          -- 	section = "terminal",
          -- 	pane = 2,
          -- 	cmd = "echo '~ LIXY ~' | figlet -f doom",
          -- 	height = 8,
          -- 	padding = 1,
          -- 	align = "center",
          -- },
          {
            title = "  " .. vim.uv.cwd(),
            padding = 1,
            align = "center",
          },
          { section = "keys", gap = 1, padding = 1 },
          {
            icon = " ",
            desc = "Edgy UI",
            padding = 1,
            key = "e",
            action = function()
              require("edgy").open()
            end,
          },
          {
            icon = " ",
            desc = "Git Staging",
            padding = 1,
            key = "a",
            action = function()
              require("tinygit").interactiveStaging()
            end,
          },
          {
            icon = " ",
            desc = "Git Modified",
            padding = 1,
            key = "m",
            action = require("telescope.builtin").git_status,
          },
          {
            icon = " ",
            desc = "Browse Repo",
            padding = 1,
            key = "b",
            action = function()
              Snacks.gitbrowse()
            end,
          },
          {
            desc = "Check Health",
            padding = 1,
            icon = "✔ ",
            key = "h",
            action = function()
              vim.cmd("checkhealth")
            end,
          },
          { section = "startup" },
          {
            -- todo, display relative paths
            pane = 2,
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            cwd = true,
            indent = 2,
            padding = 1,
          },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Log",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git log --oneline --decorate --color --graph  | head -8",
            height = 8,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status -s",
            height = 8,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
        },
      },
    },
  },

  {
    "folke/edgy.nvim",
    optional = true,
    opts = {
      animate = {
        enabled = false,
      },
    },
  },
}
