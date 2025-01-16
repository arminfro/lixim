self:
{
  ...
}:
{
  imports = map (module: import module self) ([
    ./ai.nix
    ./coding.nix
    ./editor.nix
    ./lualine.nix
    ./ui.nix
  ]);
}
