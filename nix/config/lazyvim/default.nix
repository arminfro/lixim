self:
{
  pkgs,
  lib,
  config,
  ...
}:
let
  enabledLanguagesOrNull = lib.mapAttrs (
    langKey: lang: if lang.enable then ./lang/${langKey}.nix else null
  ) config.lang;
  enabledLanguages = builtins.filter (lang: lang != null && lib.pathIsRegularFile lang) (
    builtins.attrValues enabledLanguagesOrNull
  );
  enabledExtras = {
    core = [
      ./coding/blink.nix
      ./coding/luasnip.nix
      ./coding/mini-sorround.nix
      ./coding/yanky.nix

      ./editor/inc-rename.nix
      ./editor/mini-files.nix
      ./editor/telescope.nix

      ./util/dot.nix
    ];
    balance = [
      ./editor/aerial.nix

      ./editor/overseer.nix
      ./editor/refactoring.nix

      ./formatting/biome.nix
      ./formatting/prettier.nix

      ./linting/eslint.nix

      ./test/neotest.nix

      ./ui/treesitter-context.nix
    ];
    max = [
      ./coding/neogen.nix

      ./dap/core.nix
      ./dap/nlua.nix

      ./editor/dial.nix

      ./ui/edgy.nix
      ./ui/smear-cursor.nix

      ./util/rest.nix
    ];
  };
in
{
  imports = map (module: import module self) (
    lib.flatten (
      enabledExtras.core
      ++ lib.optional (
        config.enableLvl == "lazyvim" || config.enableLvl == "balance" || config.enableLvl == "max"
      ) enabledExtras.balance
      ++ lib.optional (config.enableLvl == "lazyvim" || config.enableLvl == "max") enabledExtras.max
      ++ enabledLanguages
    )
  );

  config = {
    plugins =
      (builtins.attrValues {
        LazyVim = pkgs.vimPlugins.LazyVim.overrideAttrs (oldAttrs: {
          patches = (import ./patches { inherit config lib; });
        });
      })
      ++ (with pkgs.vimPlugins; [
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
      ])
      ++ lib.optional (config.enableLvl == "lazyvim") pkgs.vimPlugins.bufferline-nvim;

    extraPackages = with pkgs; [
      lazygit
      ripgrep
      fd

      lua-language-server
      shfmt
      stylua
    ];

    extraLazyImport = lib.optional (config.enableLvl != "lazyvim") "plugins.lazyvim";
  };
}
