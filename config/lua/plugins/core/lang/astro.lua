return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {
          init_options = {
            typescript = {
              tsdk = LazyVim.get_pkg_path(
                "vtsls",
                "node_modules/typescript/lib/vtsls-language-server/node_modules/typescript/lib"
              ),
            },
          },
        },
      },
    },
  },
}
