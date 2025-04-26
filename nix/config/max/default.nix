self:
{
  ...
}:
{
  imports = map (module: import module self) ([
    ./coding.nix
    ./editor.nix
    ./ui.nix
    ./lualine.nix
    ./rest.nix
    ./writing.nix
  ]);
}
