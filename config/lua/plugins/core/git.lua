return {
  {
    "sindrets/diffview.nvim",
    lazy = true,
    keys = {
      {
        "<leader>gD",
        ":DiffviewOpen -uno<CR>",
        desc = "Git diff workspace",
        mode = "n",
      },
      {
        "<leader>gd",
        ":DiffviewOpen<CR>",
        desc = "Git diff file",
        mode = { "n", "v" },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd(
        "FileType",
        { pattern = "DiffviewFiles", command = [[nnoremap <buffer><silent> q :DiffviewClose<CR>]] }
      )

      vim.api.nvim_create_autocmd(
        "FileType",
        { pattern = "DiffviewFileHistory", command = [[nnoremap <buffer><silent> q :DiffviewClose<CR>]] }
      )
    end,
  },

  {
    "chrisgrieser/nvim-tinygit",
    dependencies = "stevearc/dressing.nvim",
    event = "VeryLazy", -- load for status line component
    keys = {
			-- stylua: ignore start
			{ "<leader>gM", function() require("tinygit").amendOnlyMsg { forcePushIfDiverged = false } end, desc = "Edit Msg" },
			{ "<leader>ga", function() require("tinygit").interactiveStaging() end, desc = "Interactive staging" },
      -- stay with fugitive, for cmp and spellcheck support
			-- { "<leader>gc", function() require("tinygit").smartCommit { pushIfClean = false } end, desc = "Smart-commit" },
			{ "<leader>gf", function() require("tinygit").fixupCommit { autoRebase = true } end, desc = "Fixup & rebase" },
			{ "<leader>gl", function() require("tinygit").fileHistory() end, mode = { "n", "x" }, desc = "Log" },
			{ "<leader>gR", function() require("tinygit").undoLastCommitOrAmend() end, desc = "Revert last commit/amend" },
			{ "<leader>gt", function() require("tinygit").stashPush() end, desc = "Stash push" },
			{ "<leader>gT", function() require("tinygit").stashPop() end, desc = "Stash pop" },
			{ "<leader>gx", function() require("tinygit").amendNoEdit { forcePushIfDiverged = false } end, desc = "Edit Code" },
      -- stylua: ignore end
    },
    opts = {
      stage = {
        contextSize = 1,
        moveToNextHunkOnStagingToggle = true,
      },
      commit = {
        preview = true,
        conventionalCommits = { enforce = true },
        spellcheck = true,
        keepAbortedMsgSecs = 60 * 10, -- 10 mins
        -- insertIssuesOnHashSign = { enabled = true, next = "#" },
      },
      history = {
        autoUnshallowIfNeeded = true,
        diffPopup = { width = 0.9, height = 0.9, border = vim.g.borderStyle },
      },
    },
  },

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GRename", "GDelete", "GRemove", "GBrowse" },
    keys = {
      {
        "<leader>gr",
        ":Gread<CR>",
        desc = "Read",
      },
      {
        "<leader>gw",
        ":Gwrite<CR>",
        desc = "Stage file",
      },
      {
        "<leader>gc",
        ":Git commit<CR>",
        desc = "Commit",
      },
      {
        "<leader>gb",
        ":Git blame<CR>",
        desc = "Blame",
      },
    },
  },

  {
    "ruifm/gitlinker.nvim",
    lazy = true,
    keys = {
      {
        "<leader>gy",
        ":lua require'gitlinker'.get_repo_url()<CR>",
        desc = "Git yank git url",
        mode = { "x", "n" },
      },
    },
    opts = {},
  },
}
