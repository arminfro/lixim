{
  pkgs,
  lib,
  self,
  config,
}:
let
  liximConfig = (
    import ../../config/eval.nix {
      inherit
        pkgs
        self
        config
        lib
        ;
    }
  );

  neovimWrapped = pkgs.wrapNeovim liximConfig.neovimPackage {
    configure = {
      customRC = liximConfig.customRC;
      packages.all.start = [ pkgs.vimPlugins.lazy-nvim ];
    };
  };
in

pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ liximConfig.runtimePath ];
  text = ''${neovimWrapped}/bin/nvim "$@"'';
}
