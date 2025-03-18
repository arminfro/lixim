{
  pkgs,
  self,
  lib,
}:
let
  neovimByConfig =
    enableLvl:
    import ./lixim {
      inherit
        pkgs
        lib
        self
        ;
      config = {
        inherit enableLvl;
        enable = true;
        useNeovimNightly = true;
        useLatestLazyVim = false;
        lang = {
          astro.enable = true;
          css.enable = true;
          docker.enable = true;
          git.enable = true;
          html.enable = true;
          json.enable = true;
          markdown.enable = true;
          nix.enable = true;
          nushell.enable = true;
          rust.enable = true;
          sql.enable = true;
          react.enable = true;
          svelte.enable = true;
          tailwind.enable = true;
          toml.enable = true;
          typescript.enable = true;
          typst.enable = true;
          yaml.enable = true;
        };
      };
    };
in
rec {
  lazyvim = neovimByConfig "lazyvim";
  core = neovimByConfig "core";
  balance = neovimByConfig "balance";
  max = neovimByConfig "max";
  default = max;
}
