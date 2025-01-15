self:
{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = map (module: import module self) ([
    ./blink.nix
    ./telescope.nix
  ]);
}
