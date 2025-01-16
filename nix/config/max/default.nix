self:
{
  ...
}:
{
  imports = map (module: import module self) ([
    ./editor.nix
  ]);
}
