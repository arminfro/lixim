{
  self,
  isNixOsModule,
}:
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.neovim.lixim;
  inherit (lib) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types)
    submodule
    enum
    bool
    path
    str
    nullOr
    ;

  liximConfig = import ./config/eval.nix {
    inherit
      pkgs
      self
      lib
      ;
    config = cfg;
  };
in
{
  options.programs.neovim.lixim = {
    enable = mkEnableOption "lixim";
    lang = mkOption {
      type = submodule {
        options = {
          astro.enable = mkEnableOption "astro language support";
          css.enable = mkEnableOption "css language support";
          docker.enable = mkEnableOption "docker language support";
          git.enable = mkEnableOption "git language support";
          html.enable = mkEnableOption "html language support";
          json.enable = mkEnableOption "json language support";
          markdown.enable = mkEnableOption "markdown language support";
          nix.enable = mkEnableOption "nix language support";
          nushell.enable = mkEnableOption "nushell language support";
          react.enable = mkEnableOption "react language support";
          rust.enable = mkEnableOption "rust language support";
          sql.enable = mkEnableOption "sql language support";
          svelte.enable = mkEnableOption "svelte language support";
          tailwind.enable = mkEnableOption "tailwind language support";
          toml.enable = mkEnableOption "toml language support";
          typescript.enable = mkEnableOption "typescript language support";
          yaml.enable = mkEnableOption "yaml language support";
        };
      };
    };

    enableLvl = mkOption {
      default = "core";
      type = enum [
        "lazyvim"
        "core"
        "balance"
        "max"
      ];
      description = ''
        Enable level for Lazyvim plugins.
        Possible values: lazyvim, core, balance, max.

        lazyvim - just lazyvim
        core - most important plugins and configs
        balance - more features but nothing too heavy
        max - all plugins
      '';
    };

    useNeovimNightly = mkOption {
      default = true;
      type = bool;
      description = ''
        Wether to use neovim nightly or not
      '';
    };

    openAiApiPasswordCommand = mkOption {
      default = null;
      type = nullOr str;
      description = "optional, set command to read OpenAi API Key, otherwise OPENAI_API_KEY is tried";
    };

    snippetsPath = mkOption {
      default = null;
      type = nullOr path;
      description = ''
        optional, set by env `SNIPPETS_PATH` or else `vim.fn.stdpath("config") .. "/snippets"` is tried

        integrates your snippets with friendly-snippets and nvim-scissors
      '';
    };
  };

  config = mkIf cfg.enable (
    if isNixOsModule then
      {
        # todo, install extraPackages just for neovim, not globally
        environment.systemPackages = liximConfig.extraPackages;
        programs.neovim = {
          package = liximConfig.neovimPackage;
          configure = {
            inherit (liximConfig) customRC;
            packages.all.start = [ pkgs.vimPlugins.lazy-nvim ];
          };
        };
      }
    else
      {
        programs.neovim = {
          inherit (liximConfig) extraPackages;
          package = liximConfig.neovimPackage;
          extraConfig = liximConfig.customRC;
          plugins = [ pkgs.vimPlugins.lazy-nvim ];
        };
      }
  );
}
