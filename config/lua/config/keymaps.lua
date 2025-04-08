local map = vim.keymap.set

vim.keymap.del("n", "<S-h>")
map("n", "<S-TAB>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

vim.keymap.del("n", "<S-l>")
map("n", "<TAB>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

vim.keymap.del("n", "<leader>cd")
map("n", "<leader>cl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- unset some lazygit keymaps
vim.keymap.del("n", "<leader>gG") -- Lazygit (cwd)
vim.keymap.del("n", "<leader>gf") -- Git Current File History
vim.keymap.del("n", "<leader>gl") -- Git Log
vim.keymap.del("n", "<leader>l") -- lazyvim

-- easier save, new and exit
map("n", "<leader><leader>", ":wa<CR>", { desc = "Save files" })
map("n", "<leader>qw", ":wqa<CR>", { desc = "Save files and Quit" })
map("n", "<leader>Q", ":qa<CR>", { desc = "Quit all" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>!", ":qa!<CR>", { desc = "forcefully Quit" })

-- spell checker
map("n", "<leader>z", "", { desc = "+spelling" })
map("n", "<leader>zz", "1z=", { desc = "Fix to first spell suggestion" })
map("n", "<leader>zg", "<CMD>SetGermanSpellFeature<CR>", { desc = "Set German" })
map("n", "<leader>ze", "<CMD>SetEnglishSpellFeature<CR>", { desc = "Set English" })

-- Cursors Movement
map({ "n", "v" }, "<S-h>", "^", { desc = "Jump to beginning of line" })
map({ "n", "v" }, "<S-l>", "g_", { desc = "Jump to end of line" })

-- Window Managemant
map("n", "<leader>wo", ":only<CR>", { desc = "Display only current buffer" })
map("n", "<leader>wh", ":hide<CR>", { desc = "Hide current buffer" })
map("n", "<leader>wD", ":window diffthis<CR>", { desc = "Diff this window" })
map("n", "<leader>wt", ":window diffoff<CR>", { desc = "Diff off" })

-- buffer Managemant
map({ "n", "x" }, "X", ":bd<CR>", { desc = "Close Buffer" })

-- Copy to clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<leader>Y", '"+yg_', { desc = "Copy to clipboard until EOL" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- LazyVim
map("n", "<leader>xL", function()
  LazyVim.news.changelog()
end, { desc = "LazyVim Changelog" })
map("n", "<leader>xp", "<cmd>Lazy<cr>", { desc = "Plugins" })

-- floating terminal
-- map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
-- map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- -- map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
-- -- map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- map("n", "<c-/>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- map("n", "<c-_>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "which_key_ignore" })

map("n", "<leader>xm", "<cmd>messages<cr>", { desc = "Messages" })

map("n", "<leader>Xp", function()
  local root_path = vim.fs.find(".git", { path = vim.api.nvim_buf_get_name(0), upward = true })[1]
  if root_path ~= nil then
    local target_dir = vim.fs.dirname(root_path)
    vim.cmd({ cmd = "cd", args = { target_dir } })
    vim.notify("PWD chagned to " .. target_dir)
  else
    vim.notify("No git root path found")
  end
end, { desc = "PWD to files git path" })

map("n", "<leader>fD", function()
  local file_path = vim.fn.expand("%")
  local confirm = vim.fn.confirm("Delete buffer and file " .. file_path .. "?", "&Yes\n&No", 2)

  if confirm == 1 then
    os.remove(file_path)
    vim.api.nvim_buf_delete(0, { force = true })
  end
end, { desc = "Delete current file" })
