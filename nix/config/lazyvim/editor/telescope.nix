self:
{
  pkgs,
  ...
}:
# While migrating to Snacks picker, leave telescope installed but do not require default lazy telescope config
{
  plugins = with pkgs.vimPlugins; [
    telescope-nvim
    telescope-fzf-native-nvim
    dressing-nvim
  ];

  extraLazyImport = [
    # "lazyvim.plugins.extras.editor.telescope"
  ];
}
