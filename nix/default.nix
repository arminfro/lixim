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
    bool
    ;

  neovimPackage = import ./packages/lixim {
    inherit
      pkgs
      lib
      self
      ;
    config = cfg;
  };
in
{
  options.programs.lixim = {
    enable = mkEnableOption "lixim";
    lang = mkOption {
      type = (
        submodule {
          options = {
            docker.enable = mkEnableOption "docker language support";
            git.enable = mkEnableOption "git language support";
            html.enable = mkEnableOption "html language support";
            json.enable = mkEnableOption "json language support";
            markdown.enable = mkEnableOption "markdown language support";
            nix.enable = mkEnableOption "nix language support";
            nushell.enable = mkEnableOption "nushell language support";
            rust.enable = mkEnableOption "rust language support";
            svelte.enable = mkEnableOption "svelte language support";
            tailwind.enable = mkEnableOption "tailwind language support";
            toml.enable = mkEnableOption "toml language support";
            typescript.enable = mkEnableOption "typescript language support";
            yaml.enable = mkEnableOption "yaml language support";
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

    useNeovimNightly = mkOption {
      default = true;
      type = bool;
      description = ''
        Wether to use neovim nightly or not
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
