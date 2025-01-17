{ pkgs, self }:
rec {
  buildVimPlugin =
    {
      name,
      version ? "*",
      dependencies ? [ ],
      nvimSkipModule ? null,

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
      pname = name;
      src = self.inputs.${subbedName};
    });

  buildVimPlugins = plugins: builtins.map (plugin: buildVimPlugin (plugin)) plugins;
}
