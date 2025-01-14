{
  pkgs,
  ...
}:
{
  imports = [
    ./editor/telescope.nix
    ./coding/blink.nix
  ];

  config = {
    plugins = with pkgs.vimPlugins; [
      LazyVim
      bufferline-nvim
      conform-nvim
      dashboard-nvim
      flash-nvim
      gitsigns-nvim
      grug-far-nvim
      lazy-nvim
      lazydev-nvim
      lualine-nvim
      luvit-meta
      mini-ai
      mini-icons
      mini-pairs
      neo-tree-nvim
      noice-nvim
      nui-nvim
      nvim-lint
      nvim-lspconfig
      nvim-treesitter
      nvim-treesitter-textobjects
      nvim-ts-autotag
      persistence-nvim
      plenary-nvim
      snacks-nvim
      todo-comments-nvim
      tokyonight-nvim
      trouble-nvim
      ts-comments-nvim
      which-key-nvim
      {
        name = "catppuccin";
        path = catppuccin-nvim;
      }
    ];

    extraPackages = with pkgs; [
      lazygit
      ripgrep
      fd

      lua-language-server
      shfmt
      stylua
    ];
  };
}
