self:
{
  lib,
  config,
  ...
}:
let
  enabledLanguagesOrNull = lib.mapAttrs (
    langKey: lang: if lang.enable then ./${langKey}.nix else null
  ) config.lang;
  enabledLanguages = builtins.filter (lang: lang != null && lib.pathIsRegularFile lang) (
    builtins.attrValues enabledLanguagesOrNull
  );
in
{
  imports = map (module: import module self) (enabledLanguages);
}
