return {
  {
    "phelipetls/jsonpath.nvim",
    ft = { "json" },
    -- config = function()
    -- 	if vim.fn.exists("+winbar") == 1 then
    -- 		vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
    -- 	end
    -- end,
    keys = {
      {
        "<leader>cY",
        function()
          vim.fn.setreg("+", require("jsonpath").get())
        end,
        desc = "Copy Jsonpath",
      },
    },
  },
}
