self:
{
  pkgs,
  lib,
  config,
  utils,
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
      ./coding/friendly-snippets.nix
      ./coding/mini-sorround.nix
      ./coding/yanky.nix

      ./editor/inc-rename.nix
      ./editor/neo-tree.nix
      ./editor/telescope.nix

      ./util/dot.nix

      ./ui/treesitter-context.nix
    ];
    balance = [
      ./editor/aerial.nix

      ./editor/overseer.nix
      ./editor/refactoring.nix

      ./formatting/biome.nix
      ./formatting/prettier.nix

      ./linting/eslint.nix

      ./test/neotest.nix
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

  lazyVimPackage =
    if builtins.hasAttr "useLatestLazyVim" config && config.useLatestLazyVim then
      utils.buildVimPlugin {
        name = "LazyVim";
        nvimSkipModule = [
          "lazyvim.config.init"
          "lazyvim.config.keymaps"
          "lazyvim.plugins.extras.ai.tabnine"
          "lazyvim.plugins.extras.coding.neogen"
          "lazyvim.plugins.extras.editor.snacks_picker"
          "lazyvim.plugins.extras.editor.fzf"
          "lazyvim.plugins.extras.editor.telescope"
          "lazyvim.plugins.extras.formatting.prettier"
          "lazyvim.plugins.extras.lang.markdown"
          "lazyvim.plugins.extras.lang.omnisharp"
          "lazyvim.plugins.extras.lang.python"
          "lazyvim.plugins.extras.lang.svelte"
          "lazyvim.plugins.extras.lang.typescript"
          "lazyvim.plugins.init"
          "lazyvim.plugins.ui"
          "lazyvim.plugins.xtras"
          "lazyvim.util.extras"
          "lazyvim.util.init"
          "lazyvim.util.plugin"
          "lazyvim.types"
        ];
      }
    else
      pkgs.vimPlugins.LazyVim;
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
        LazyVim = lazyVimPackage.overrideAttrs (oldAttrs: {
          patches = (import ./patches { inherit config lib; });
        });
        gitsigns-nvim = pkgs.vimPlugins.gitsigns-nvim.overrideAttrs (oldAttrs: {
          patches = [ ./patches/fix-gitsigns.patch ];
        });
      })
      ++ (with pkgs.vimPlugins; [
        conform-nvim
        dashboard-nvim
        flash-nvim
        grug-far-nvim
        lazy-nvim
        lazydev-nvim
        lualine-nvim
        luvit-meta
        mini-ai
        mini-icons
        mini-pairs
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
