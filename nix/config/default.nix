{ lib, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib.types)
    listOf
    package
    ;
in
{
  imports = [ ./lazyvim ];

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

    enable_lvl = mkOption {
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

  config = {
    enable_lvl = "lazyvim";
  };
}
