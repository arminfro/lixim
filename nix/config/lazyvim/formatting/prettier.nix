self:
{
  pkgs,
  ...
}:
{
  extraPackages = [
    pkgs.nodePackages.prettier
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.formatting.prettier"
  ];

  extraLuaConfig = [
    # lua
    ''
      vim.g.lazyvim_prettier_needs_config = true
    ''
  ];
}
