{ lib, inputs }:
rec {
  buildVimPlugin =
    {
      name,
      version ? "*",
      dependencies ? [ ],
      nvimSkipModule ? null,
      pkgs, # todo
      ...
    }:
    let
      subbedName = builtins.replaceStrings [ "." ] [ "-" ] name;
    in
    (pkgs.vimUtils.buildVimPlugin {
      inherit
        version
        dependencies
        nvimSkipModule
        ;
      pname = subbedName;
      src = inputs.${subbedName};
    });

  buildVimPlugins = builtins.map (plugin: buildVimPlugin plugin);
}
