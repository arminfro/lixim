-- vi: ft=lua

vim.api.nvim_create_user_command("PasteGitStatus", ":r! git status -s", { desc = "Paste git status short output" })

vim.api.nvim_create_user_command("PrintCurrentFiletype", function()
  print(vim.bo.filetype)
end, { desc = "Print current filetype" })

-- LspHoverToggle command to toggle an auto command for CursorHold event
local lsp_hover_enabled = false
vim.api.nvim_create_user_command("LspHoverToggle", function()
  lsp_hover_enabled = not lsp_hover_enabled
  if lsp_hover_enabled then
    vim.notify("LSP auto-hover enabled", vim.log.levels.INFO)
    vim.cmd("au CursorHold * lua vim.lsp.buf.hover()")
  else
    vim.notify("LSP auto-hover disabled", vim.log.levels.INFO)
    vim.cmd("au! CursorHold")
  end
end, { desc = "LSP auto Hover on CursorHold" })

---copying file information
-- https://github.com/chrisgrieser/nvim-genghis/blob/749027d470d1081541c205a46d8b98e55fe311de/lua/genghis.lua#L141
---@param operation string filename|filepath
local function copyOp(operation)
  local reg = '"'
  local clipboardOpt = vim.opt.clipboard:get()
  local useSystemClipb = #clipboardOpt > 0 and clipboardOpt[1]:find("unnamed")
  if useSystemClipb then
    reg = "+"
  end

  local toCopy = vim.fn.expand("%:p")
  if operation == "filename" then
    toCopy = vim.fn.expand("%:t")
  end

  vim.fn.setreg(reg, toCopy)
  vim.notify("COPIED\n" .. toCopy)
end

vim.api.nvim_create_user_command("CopyFileName", function()
  copyOp("filename")
end, { desc = "Copy's current file name to clipboard" })

vim.api.nvim_create_user_command("CopyFilePath", function()
  copyOp("filepath")
end, { desc = "Copy's current file path to clipboard" })

vim.api.nvim_create_user_command("PrintCWD", function()
  print(vim.fn.getcwd())
end, { desc = "Print current working directory" })
