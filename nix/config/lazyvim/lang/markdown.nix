self:
{
  pkgs,
  config,
  ...
}:
let
  enable = config.lang.markdown.enable;
  emptyListOr = list: if enable then list else [ ];
in
{
  extraPackages = emptyListOr (
    with pkgs;
    [
      markdownlint-cli2
      marksman
      # inherit (self.packages.${pkgs.stdenv.hostPlatform.system}) markdown-toc; # todo
    ]
  );

  plugins = emptyListOr (
    with pkgs.vimPlugins;
    [
      markdown-preview-nvim
      render-markdown-nvim
    ]
  );

  extraLazyImport = emptyListOr [
    "lazyvim.plugins.extras.lang.markdown"
  ];
}
