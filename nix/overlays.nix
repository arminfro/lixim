{
  self,
  pkgs,
}:
let
  buildVimPlugin =
    {
      name,
      src,
      version ? "*",
      dependencies ? [ ],
      nvimSkipModule ? null,

    }:
    (pkgs.vimUtils.buildVimPlugin {
      inherit
        src
        version
        dependencies
        nvimSkipModule
        ;
      pname = name;
    });

  customPluginsDef = [
    { name = "tailwindcss-colorizer-cmp.nvim"; }
    {

      name = "telescope-alternate";
      nvimSkipModule = "telescope-alternate.telescope";
    }
    {
      name = "blink-cmp-dictionary";
      nvimSkipModule = "blink-cmp-dictionary";
    }
    {
      name = "telescope-heading.nvim";
    }
    {
      name = "telescope-lazy.nvim";
    }
    {
      name = "telescope-node-modules.nvim";
    }
    {
      name = "telescope-env.nvim";
    }
    {
      name = "telescope-luasnip.nvim";
    }
    {
      name = "nvim-scissors";
      nvimSkipModule = "scissors.2-picker.telescope";
    }
    { name = "nvim-window"; }
    { name = "ts-node-action"; }
    { name = "vim-mkdir"; }
    {
      name = "nvim-tinygit";
      nvimSkipModule = [
        "tinygit.commands.staging.telescope"
        "tinygit.statusline.branch-state"
      ];
    }

    { name = "markdowny.nvim"; }
    { name = "auto-pandoc.nvim"; }
    {
      name = "nvim-toc";
      dependencies = [
        pkgs.vimPlugins.nvim-treesitter
      ];
    }
    { name = "mdeval.nvim"; }

    { name = "hl_match_area.nvim"; }
    {
      name = "nvim-devdocs";
      nvimSkipModule = [
        "nvim-devdocs.build"
        "nvim-devdocs.completion"
        "nvim-devdocs.config"
        "nvim-devdocs"
        "nvim-devdocs.keymaps"
        "nvim-devdocs.list"
        "nvim-devdocs.log"
        "nvim-devdocs.operations"
        "nvim-devdocs.pickers"
      ];
    }
    { name = "template-string.nvim"; }
    { name = "fsread.nvim"; }
    {
      name = "nvim-fundo";
      nvimSkipModule = [
        "fundo.fs.init"
        "fundo.fs.uvwrapper"
        "fundo.lib.mutex"
        "fundo.lib.semaphore"
        "fundo.main"
        "fundo.manager"
        "fundo.model.undo"
      ];
    }
    { name = "promise-async"; }
    { name = "hand-side-fix.nvim"; }

    { name = "git-blame.nvim"; }
    { name = "lualine-so-fancy.nvim"; }
    { name = "lualine-spell-status"; }
    { name = "nvim-origami"; }

    { name = "lualine-diagnostic-message"; }
    { name = "nvim-dr-lsp"; }

    { name = "mistake.nvim"; }
    { name = "jsonpath-nvim"; nvimSkipModule = [ "jsonpath"]; }
  ];
in
[
  (final: prev: {
    vimPlugins =
      prev.vimPlugins
      // {
        LazyVim = prev.vimPlugins.LazyVim.overrideAttrs (oldAttrs: {
          patches = import ./config/lazyvim/patches;
        });
      }
      // builtins.listToAttrs (
        builtins.map (
          plugin:
          let
            subbedName = builtins.replaceStrings [ "." ] [ "-" ] plugin.name;
          in
          {
            name = subbedName;
            value = buildVimPlugin (
              plugin
              // {
                src = self.inputs.${subbedName};
              }
            );
          }
        ) customPluginsDef
      );
  })
  (final: prev: {
    markdown-toc = pkgs.callPackage ./pkgs/markdown-toc { };
  })
]
