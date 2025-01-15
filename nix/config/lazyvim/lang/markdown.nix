self:
{
  pkgs,
  config,
  ...
}:
{
  extraPackages = (
    with pkgs;
    [
      markdownlint-cli2
      marksman
      # inherit (self.packages.${pkgs.stdenv.hostPlatform.system}) markdown-toc; # todo
    ]
  );

  plugins = (
    with pkgs.vimPlugins;
    [
      markdown-preview-nvim
      render-markdown-nvim
    ]
  );

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.markdown"
  ];
}
