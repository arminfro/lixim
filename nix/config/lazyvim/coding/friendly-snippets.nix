self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    friendly-snippets
  ];
}
