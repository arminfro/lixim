self:
{
  lib,
  config,
  ...
}:
let
  enabledLanguagesOrNull = lib.mapAttrs (
    lang: value: if value.enable then ./${lang}.nix else null
  ) config.lang;
  enabledLanguages = builtins.filter (lang: lang != null && lib.pathIsRegularFile lang) (
    builtins.attrValues enabledLanguagesOrNull
  );
in
{
  imports = map (module: import module self) (enabledLanguages);
}
