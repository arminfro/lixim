---@class LazyUtilCore
local lazySetup = {
  defaults = {
    lazy = true,
  },
  dev = {
    -- reuse files from pkgs.vimPlugins.*
    path = vim.g.plugin_path,
    patterns = { "." },
    -- fallback to download
    fallback = false,
  },
  spec = {
    vim.list_extend(
      vim.list_extend({
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
      }, vim.g.extra_lazy_import),
      {
        { "williamboman/mason-lspconfig.nvim", enabled = false },
        { "williamboman/mason.nvim", enabled = false },
        { "jaybaby/mason-nvim-dap.nvim", enabled = false },
        {
          "nvim-treesitter/nvim-treesitter",
          init = function()
            -- Put treesitter path as first entry in rtp
            vim.opt.rtp:prepend(vim.g.treesitter_path)
          end,
          opts = function(_, opts)
            opts.ensure_installed = {}
          end,
          -- opts = { auto_install = false, ensure_installed = {} },
        },
      }
    ),
  },
  performance = {
    rtp = {
      -- Setup correct config path
      paths = { vim.g.config_path },
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

require("lazy").setup(lazySetup)
require("config.globals")
require("config.commands")
require("config.close-unused-buffers")
