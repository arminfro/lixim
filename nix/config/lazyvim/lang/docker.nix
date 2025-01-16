self:
{
  pkgs,
  config,
  lib,
  ...
}:
{
  extraPackages = with pkgs; [
    hadolint
    dockerfile-language-server-nodejs
    docker-compose-language-service # todo, does not seem to work
  ];

  extraLazyImport = [
    "lazyvim.plugins.extras.lang.docker"
  ];
}
