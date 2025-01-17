{
  self,
  isNixOsModule,
  neovimByConfig,
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

  liximConfig = import ./config self { inherit lib config; };

  packageConfig =
    if isNixOsModule then
      {
        environment.systemPackages = [
          self.packages.${pkgs.system}.default
        ];
      }
    else
      {
        home.packages = [
          self.packages.${pkgs.system}.default
        ];
      };
in
{
  imports = map (module: import module self) [

  ];

  options.programs.lixim = {
    enable = lib.options.mkEnableOption "lixim";
  } // liximConfig.options;

  config = lib.mkIf cfg.enable packageConfig;

}
