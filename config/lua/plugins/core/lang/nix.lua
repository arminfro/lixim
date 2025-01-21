return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        statix = {},
      },
    },
  },

  {
    "luckasRanarison/nvim-devdocs",
    optional = true,
    opts = { ensure_installed = { "nix" } },
  },
}
