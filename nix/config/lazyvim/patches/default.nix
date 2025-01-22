{ config, lib }:
[
  ./adapt-prettier-to-fit-biome-usage.patch
  ./fix-js-debug-ref.patch
]
++ lib.optional (config.enableLvl != "lazyvim") ./lualine.patch
