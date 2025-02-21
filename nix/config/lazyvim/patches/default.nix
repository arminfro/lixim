{ config, lib }:
[
  ./adapt-prettier-to-fit-biome-usage.patch
  ./fix-js-debug-ref.patch
  ./mv-help-integration-in-edgy-to-the-right.patch
]
++ lib.optional (config.enableLvl != "lazyvim") ./lualine.patch
