self:
{
  pkgs,
  ...
}:
{
  plugins = with pkgs.vimPlugins; [
    telescope-nvim
    dressing-nvim
  ];

  extraLuaConfig = # lua
    ''
      vim.g.lazyvim_picker = "telescope"
    '';

  extraLazyImport = [
    "lazyvim.plugins.extras.editor.telescope"
  ];
}
