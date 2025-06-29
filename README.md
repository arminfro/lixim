# Lixim - Neovim Editor with Custom LazyVim Setup

`lixim` is my personal Neovim configuration based on Nix and LazyVim.

It features a pre-configured `neovim` program, accessible as a Nix package, or configured through Nix modules.

It's usable in four variants:

- `lazyvim` includes all LazyVim extras which are implemented
  - useful for debugging and development purposes, such as comparing the `checkhealth` output
  - when not choosing `lazyvim` than LazyVim extras includes depends on `core, balance, max` value
- `core` includes most important plugins and configurations
- `balance` includes more features but nothing too heavy
- `max` includes all plugins

Each option builds upon the previous one, so selecting `max` includes all configurations.

## Packages

All variants are pre-configured, to try out the `core` variant, run `XDG_CONFIG_HOME=$(mktemp -d) nix run github:arminfro/lixim#core`.

The default package is the `max` variant.

## Configuration

Most of the configuration is achieved by setting `enableLvl` to one of the following options: `lazyvim, core, balance, max`.

Example configuration using the `homeManagerModule`:

```nix
{ inputs, pkgs, ... }:
{
  imports = [ inputs.lixim.homeManagerModules.default ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    lixim = {
      enable = true;
      enableLvl = "max";

      # optionals:
      useNeovimNightly = true;
      useLatestLazyVim = false;

      # set by env `SNIPPETS_PATH` or else `vim.fn.stdpath("config") .. "/snippets"`
      snippetsPath = /home/user/Workspace/nix/lixim/config/snippets;

      # set command to read OpenAi API Key, otherwise OPENAI_API_KEY is tried
      openAiApiPasswordCommand = "pass Ai/open-ai/api-key";

      # set by env `ZK_NOTEBOOK_DIR`, integration for zk-org.github.io/zk
      zkNotebookPath = /home/user/Documents/zk-notes;

      lang = {
        astro.enable = true;
        css.enable = true;
        docker.enable = true;
        git.enable = true;
        html.enable = true;
        json.enable = true;
        just.enable = true;
        markdown.enable = true;
        nix.enable = true;
        nushell.enable = true;
        react.enable = true;
        python.enable = true;
        rust.enable = (pkgs.system != "aarch64-linux");
        sql.enable = true;
        svelte.enable = true;
        tailwind.enable = true;
        toml.enable = true;
        typescript.enable = true;
        typst.enable = true;
        yaml.enable = true;
      };
    };
  };
}
```

To use the above configuration add `lixim` input in `flake.nix` file:

```nix
{
  inputs = {
    lixim = {
      url = "github:arminfro/lixim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
```

## Credits

Sources of inspiration:

- Detached fork of: [lazyvim-nix](https://github.com/jla2000/lazyvim-nix)
- [LazyVim-Module](https://github.com/matadaniel/LazyVim-module)
