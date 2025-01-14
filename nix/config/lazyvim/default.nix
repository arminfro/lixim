self:
{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = map (module: import module self) [
    ./coding/blink.nix
    ./coding/luasnip.nix
    ./coding/mini-sorround.nix
    ./coding/neogen.nix
    ./coding/yanky.nix

    ./editor/aerial.nix
    ./editor/dial.nix
    ./editor/inc-rename.nix
    ./editor/mini-files.nix
    ./editor/overseer.nix
    ./editor/refactoring.nix
    ./editor/telescope.nix

    ./formatting/prettier.nix

    ./lang/git.nix
    ./lang/json.nix
    ./lang/markdown.nix
    ./lang/nix.nix
    ./lang/tailwind.nix
    ./lang/typescript.nix

    ./linting/eslint.nix

    ./test/neotest.nix

    ./util/dot.nix
    ./util/rest.nix
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
