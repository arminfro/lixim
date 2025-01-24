-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.cmd("packadd cfilter")

-- vi: ft=lua

local opt = vim.opt
local globals = vim.g

-- opt.winbar = "%=%m %f"

opt.listchars = {
  -- space = "⋅",
  -- nbsp = "_",
  tab = "__",
  eol = "↴",
  trail = "•",
  extends = "❯",
  precedes = "❮",
}

opt.clipboard = "unnamed"

globals.root_spec = { "cwd" }

-- todo, declaration in telescope.nix is not having the seeked effect
globals.lazyvim_picker = "telescope"

globals.maplocalleader = ","

globals.snacks_animate = false
