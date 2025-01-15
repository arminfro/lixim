{ self, pkgs }:
let
  build-custom-plugin =
    {
      name,
      src,
      version ? "*",
      dependencies ? [ ],
      nvimSkipModule ? null,

    }:
    (pkgs.vimUtils.buildVimPlugin {
      inherit
        src
        version
        dependencies
        nvimSkipModule
        ;
      pname = name;
    });
in
[
  (final: prev: {
    vimPlugins = prev.vimPlugins // {
      LazyVim = prev.vimPlugins.LazyVim.overrideAttrs (oldAttrs: {
        patches = import ./config/lazyvim/patches;
      });
      tailwindcss-colorizer-cmp-nvim = build-custom-plugin {
        name = "tailwindcss-colorizer-cmp.nvim";
        src = self.inputs.tailwindcss-colorizer-cmp-nvim;
      };
    };
  })
]
