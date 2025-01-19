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
    ]
    ++ [
      (pkgs.callPackage ../../../packages/markdown-toc { })
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
