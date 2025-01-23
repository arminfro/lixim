return {

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        nix = { "statix" },
      },
    },
  },

  -- todo, statix should work by this config, but it's not, needs digging, rm nvim-lint when done
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       statix = {},
  --     },
  --   },
  -- },

  {
    "luckasRanarison/nvim-devdocs",
    optional = true,
    opts = { ensure_installed = { "nix" } },
  },
}
