self:
{
  ...
}:
{
  imports = map (module: import module self) ([
    ./blink.nix
    ./coding.nix
    ./editor.nix
    ./git.nix
    ./lsp.nix
    ./lualine.nix
    ./telescope.nix
    ./ui.nix
    ./writing.nix
    ./zk.nix
  ]);
}
