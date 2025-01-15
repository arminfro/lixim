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
    ./coding.nix
    ./editor.nix
    ./telescope.nix
  ]);
}
