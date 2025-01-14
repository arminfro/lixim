{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    blink-cmp
    friendly-snippets

  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.coding.blink"
  ];
}
