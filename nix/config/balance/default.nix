self:
{
  ...
}:
{
  imports = map (module: import module self) ([
    ./ai.nix
    ./coding.nix
  ]);
}
