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
  cfg = config.programs.lixim;
  inherit (lib) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types)
    submodule
    enum
    ;

  liximSettings =
    (pkgs.lib.evalModules {
      modules = [
        (import ./config self)
      ];
      specialArgs = {
        inherit
          pkgs
          ;
        config = cfg;
        utils = import ./utils.nix { inherit pkgs self; };
      };
    }).config;

  neovimByConfig =
    config:
    import ./pkgs/lixim {
      inherit
        pkgs
        lib
        self
        ;
      config = liximSettings;
    };

  neovimPackage = neovimByConfig config;
in
{
  options.programs.lixim = {
    enable = mkEnableOption "lixim";
    lang = mkOption {
      type = (
        submodule {
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
  };

  config = mkIf cfg.enable (
    if isNixOsModule then
      {
        environment.systemPackages = [
          neovimPackage
        ];
      }
    else
      {
        home.packages = [
          neovimPackage
        ];
      }
  );

}
