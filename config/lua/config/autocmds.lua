local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

local function save_all_modifed_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_get_option_value("modified", { buf = buf }) and vim.fn.getbufvar(buf, "&modifiable") ~= 0 then
      vim.api.nvim_buf_call(buf, function()
        vim.cmd([[silent! update]])
      end)
    end
  end
end

vim.api.nvim_create_autocmd({ "FocusLost" }, {
  callback = save_all_modifed_buffers,
  desc = "Save all modified buffers when loosing focus",
  pattern = "*",
  group = augroup("autosave_on_FocusLost"),
})

vim.api.nvim_create_autocmd({ "TermEnter" }, {
  callback = save_all_modifed_buffers,
  desc = "Save all modified buffers when entering Terminal",
  pattern = "*",
  group = augroup("autosave_on_TermEnter"),
})

-- quit some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  desc = "Quit some filetypes easily with q",
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
