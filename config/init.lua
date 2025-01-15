-- print(vim.inspect(vim.g.extra_lazy_import))
print(vim.g.lazyvim_picker)

require("lazy").setup({
  defaults = { lazy = true },
  dev = {
    -- reuse files from pkgs.vimPlugins.*
    path = vim.g.plugin_path,
    patterns = { "." },
    -- fallback to download
    fallback = false,
  },
  spec = {
    vim.list_extend({
      { "LazyVim/LazyVim", import = "lazyvim.plugins" },
      -- { import = "lazyvim.plugins.extras.coding.yanky" },
      -- { import = "lazyvim.plugins.extras.dap.core" },
      -- -- { import = "lazyvim.plugins.extras.lang.clangd" },
      -- -- { import = "lazyvim.plugins.extras.lang.cmake" },
      -- { import = "lazyvim.plugins.extras.lang.markdown" },
      -- -- { import = "lazyvim.plugins.extras.lang.rust" },
      -- { import = "lazyvim.plugins.extras.lang.yaml" },
      -- { import = "lazyvim.plugins.extras.lsp.none-ls" },
      -- { import = "lazyvim.plugins.extras.test.core" },
      -- { import = "lazyvim.plugins.extras.util.project" },
      -- The following configs are needed for fixing lazyvim on nix
      -- force enable telescope-fzf-native.nvim
      -- { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
      -- disable mason.nvim, use config.extraPackages
      { "williamboman/mason-lspconfig.nvim", enabled = false },
      { "williamboman/mason.nvim", enabled = false },
      { "jaybaby/mason-nvim-dap.nvim", enabled = false },
      -- uncomment to import/override with your plugins
      -- { import = "plugins" },
      -- put this line at the end of spec to clear ensure_installed
      {
        "nvim-treesitter/nvim-treesitter",
        init = function()
          -- Put treesitter path as first entry in rtp
          vim.opt.rtp:prepend(vim.g.treesitter_path)
        end,
        opts = function(_, opts)
          opts.ensure_installed = {}
          opts.auto_install = false
        end,
        -- opts = { auto_install = false, ensure_installed = {} },
      },
    }, vim.g.extra_lazy_import),
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
})
