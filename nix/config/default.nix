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
    [
      ./lazyvim
    ]
    ++ lib.optional (
      config.enableLvl == "core" || config.enableLvl == "balance" || config.enableLvl == "max"
    ) ./core
  );
  # ++ lib.optional (config.enableLvl == "balance" || config.enableLvl == "max") ./balance
  # ++ lib.optional (config.enableLvl == "max") ./max;

  options = {
    plugins = mkOption {
      default = [ ];
      description = ''
        List of vim plugins to install.
      '';
      example = ''
        [ pkgs.vimPlugins.undotree ]
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

    lang = mkOption {
      type = (
        lib.types.submodule {
          options = {
            git = mkEnableOption "git language support";
            json = mkEnableOption "json language support";
            markdown = mkEnableOption "markdown language support";
            nix = mkEnableOption "nix language support";
            tailwind = mkEnableOption "tailwind language support";
            typescript = mkEnableOption "typescript language support";
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
