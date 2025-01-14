self:
{
  pkgs,
  config,
  ...
}:
let
  enable = config.lang.tailwind.enable;
  emptyListOr = list: if enable then list else [ ];
in
{
  extraPackages = emptyListOr [ pkgs.tailwindcss-language-server ];

  plugins = emptyListOr [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "tailwindcss-colorizer-cmp.nvim";
      version = "2024-09-27";
      src = self.inputs.tailwindcss-colorizer-cmp-nvim;
    })
  ];

  extraLazyImport = emptyListOr [
    "lazyvim.plugins.extras.lang.tailwind"
  ];
}
