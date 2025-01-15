self:
{
  pkgs,
  config,
  ...
}:
{
  extraPackages = [ pkgs.tailwindcss-language-server ];

  plugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "tailwindcss-colorizer-cmp.nvim";
      version = "2024-09-27";
      src = self.inputs.tailwindcss-colorizer-cmp-nvim;
    })
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.tailwind"
  ];
}
