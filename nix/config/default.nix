self:
{ lib, config, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib.types)
    listOf
    package
    oneOf
    submodule
    str
    ;
in
{
  imports = map (module: import module self) (
    lib.optional (config.enableLvl == "max") ./max
    ++ lib.optional (config.enableLvl == "balance" || config.enableLvl == "max") ./balance
    ++ lib.optional (
      config.enableLvl == "core" || config.enableLvl == "balance" || config.enableLvl == "max"
    ) ./core
    ++ [ ./lazyvim ]
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
      type = listOf (oneOf [
        package
        (submodule {
          options = {
            name = mkOption {
              type = str;
            };
            path = mkOption {
              type = package;
            };
          };
        })
      ]);
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
      default = [ ];
      type = listOf str;
      example = ''
        vim.g.lazyvim_picker = "telescope"
      '';
    };

    extraLazyImport = mkOption {
      default = [ ];
      type = listOf str;
      example = ''
        [
          "lazyvim.plugins.extras.editor.telescope"
        ]
      '';
    };

    extraMasonPath = mkOption {
      default = [ ];
      type = listOf (submodule {
        options = {
          name = mkOption {
            type = str;
          };
          path = mkOption {
            type = package;
          };
        };
      });
      example = ''
        [ { name = "packages/svelte-language-server/node_modules/typescript-svelte-plugin"; path = pkgs.svelte-language-server; } ]
      '';
    };
  };
}
