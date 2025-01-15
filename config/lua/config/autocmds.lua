local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FocusLost" }, {
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_get_option_value("modified", { buf = buf }) and vim.fn.getbufvar(buf, "&modifiable") ~= 0 then
        vim.api.nvim_buf_call(buf, function()
          vim.cmd([[silent! update]])
        end)
      end
    end
  end,
  pattern = "*",
  group = augroup("autosave"),
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    setCmpDictionaryByCurrentLanguages(vim.opt.spelllang:get())
  end,
  pattern = "*",
  group = augroup("set_cmp_dictionary"),
})

-- quit some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("quit_with_q"),
  pattern = {
    "dap-float",
    "man",
    "git",
    "fugitiveblame",
    "dapui_console",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = event.buf, silent = true })
  end,
})
