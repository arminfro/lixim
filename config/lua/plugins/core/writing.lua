return {
  -- todo, move parts to lang.markdown
  {
    -- markdown helper
    -- <C-k> add link to visually selected text
    -- <C-b> toggle visually selected text bold
    -- <C-i> toggle visually selected text italic
    -- <C-c> toggle visually selected text inline code
    "antonk52/markdowny.nvim",
    config = function()
      require("markdowny").setup({ filetypes = { "markdown", "txt" } })
    end,
  },

  -- convert markdown using pandoc
  {
    "jghauser/auto-pandoc.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      {
        "<leader>Xm",
        function()
          require("auto-pandoc").run_pandoc()
        end,
        desc = "Compile Markdown with Pandoc",
      },
    },
    event = "BufRead",
    config = function()
      require("auto-pandoc")
    end,
  },

  {
    "HakonHarnes/img-clip.nvim",
    keys = {
      {
        "<leader>ei",
        function()
          local dir_path = get_git_root_by_path(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")) .. "/assets"
          require("img-clip").paste_image({
            dir_path = dir_path,
          })
        end,
        desc = "Paste image",
      },
    },
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        use_absolute_path = true,
        copy_images = true,
      },
      filetypes = {
        markdown = { download_images = true },
      },
    },
  },

  -- markdown in vim float window rendering
  {
    "ellisonleao/glow.nvim",
    ft = { "markdown", "txt" },
    cmd = "Glow",
    config = true,
    keys = {
      { "<leader>Xg", "<cmd>Glow<CR>", desc = "Glow Markdown render" },
    },
  },

  {
    "richardbizik/nvim-toc",
    ft = { "markdown", "txt" },
    dependencies = { "nvim-treesitter" },
    opts = {},
    keys = {
      { "<leader>e", "", desc = "+edit" },
      {
        "<leader>et",
        ":TOC<CR>",
        desc = "Generate TOC",
      },
    },
  },

  {
    "jubnzv/mdeval.nvim",
    ft = { "markdown" },
    config = function()
      vim.g.markdown_fenced_languages = { "bash", "sh" }
      require("mdeval").setup({
        eval_options = {}, -- temp, errors if not passed
      })
    end,
    keys = {
      {
        "<leader>Xe",
        "<cmd>lua require 'mdeval'.eval_code_block()<CR>",
        desc = "Evaluate Codeblock in md",
      },
    },
  },
}
