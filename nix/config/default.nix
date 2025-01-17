self:
{ lib, config, ... }:
let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types)
    listOf
    package
    ;
in
{
  imports = map (module: import module self) (
    # reverseList happens to give the right order: `lazyvim` -> `core` -> `balance` -> `max`,
    lib.reverseList (
      [
        ./lazyvim
      ]
      ++ lib.optional (
        config.enableLvl == "core" || config.enableLvl == "balance" || config.enableLvl == "max"
      ) ./core
      ++ lib.optional (config.enableLvl == "balance" || config.enableLvl == "max") ./balance
      ++ lib.optional (config.enableLvl == "max") ./max
    )
  );

  options = {
    plugins = mkOption {
      default = [ ];
      description = ''
        List of vim plugins to install.
      '';
      example = ''
        [ pkgs.vimPlugins.undotree ]
        or
        [ { name = "UndoTree"; path = pkgs.vimPlugins.undotree; } ]
      '';
      type = lib.types.listOf (
        lib.types.oneOf [
          lib.types.package
          (lib.types.submodule {
            options = {
              name = mkOption {
                type = lib.types.string;
              };
              path = mkOption {
                type = lib.types.package;
              };
            };
          })
        ]
      );
    };

    extraPackages = mkOption {
      default = [ ];
      description = ''
        List of runtime dependencies
      '';
      example = ''
        [ pkgs.ripgrep ]
      '';
      type = listOf package;
    };

    extraLuaConfig = mkOption {
      default = "";
      type = lib.types.string;
    };

    extraLazyImport = mkOption {
      default = [ ];
      type = lib.types.listOf lib.types.string;
      example = ''
        [
          "lazyvim.plugins.extras.editor.telescope"
        ]
      '';
    };

    extraMasonPath = mkOption {
      default = [ ];
      type = lib.types.listOf (lib.types.submodule {
            options = {
              name = mkOption {
                type = lib.types.string;
              };
              path = mkOption {
                type = lib.types.package;
              };
            };
          });
      example = ''
        [ { name = "packages/svelte-language-server/node_modules/typescript-svelte-plugin"; path = pkgs.svelte-language-server; } ]
      '';
    };

    lang = mkOption {
      type = (
        lib.types.submodule {
          options = {
            docker = mkEnableOption "docker language support";
            git = mkEnableOption "git language support";
            html = mkEnableOption "html language support";
            json = mkEnableOption "json language support";
            markdown = mkEnableOption "markdown language support";
            nix = mkEnableOption "nix language support";
            nushell = mkEnableOption "nushell language support";
            rust = mkEnableOption "rust language support";
            svelte = mkEnableOption "svelte language support";
            tailwind = mkEnableOption "tailwind language support";
            toml = mkEnableOption "toml language support";
            typescript = mkEnableOption "typescript language support";
            yaml = mkEnableOption "yaml language support";
          };
        }
      );
    };

    enableLvl = mkOption {
      default = "core";
      type = lib.types.enum [
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
  };
}
