local function buf_is_big(bufnr)
  local max_filesize = 100 * 1024 -- 100 KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  if ok and stats and stats.size > max_filesize then
    return true
  else
    return false
  end
end

-- todo, use global defintion
local merge_arrays = function(array1, array2)
  local ret = {}
  for _, value in ipairs(array1) do
    table.insert(ret, value)
  end
  for _, value in ipairs(array2) do
    table.insert(ret, value)
  end
  return ret
end

local set_keymap = function(opts)
  opts.keymap.preset = "default"
  opts.keymap["<Tab>"] = {
    function(cmp)
      if cmp.snippet_active() then
        return cmp.accept()
      else
        return cmp.select_next()
      end
    end,
    "fallback",
  }
  opts.keymap["<S-Tab>"] = { "select_prev", "fallback" }
  opts.keymap["<CR>"] = { "accept", "fallback" }
end

local set_quick_select = function(opts)
  opts.keymap["<A-1>"] = {
    function(cmp)
      cmp.accept({ index = 1 })
    end,
  }
  opts.keymap["<A-2>"] = {
    function(cmp)
      cmp.accept({ index = 2 })
    end,
  }
  opts.keymap["<A-3>"] = {
    function(cmp)
      cmp.accept({ index = 3 })
    end,
  }
  opts.keymap["<A-4>"] = {
    function(cmp)
      cmp.accept({ index = 4 })
    end,
  }
  opts.keymap["<A-5>"] = {
    function(cmp)
      cmp.accept({ index = 5 })
    end,
  }
  opts.keymap["<A-6>"] = {
    function(cmp)
      cmp.accept({ index = 6 })
    end,
  }
  opts.keymap["<A-7>"] = {
    function(cmp)
      cmp.accept({ index = 7 })
    end,
  }
  opts.keymap["<A-8>"] = {
    function(cmp)
      cmp.accept({ index = 8 })
    end,
  }
  opts.keymap["<A-9>"] = {
    function(cmp)
      cmp.accept({ index = 9 })
    end,
  }
  opts.keymap["<A-0>"] = {
    function(cmp)
      cmp.accept({ index = 10 })
    end,
  }
  opts.completion.menu.draw.columns = { { "item_idx" }, { "label", "label_description", gap = 1 }, { "kind_icon" } }
  opts.completion.menu.draw.components = {
    item_idx = {
      text = function(ctx)
        return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
      end,
    },
    kind_icon = {
      ellipsis = false,
      text = function(ctx)
        local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
        return kind_icon
      end,
      -- Optionally, you may also use the highlights from mini.icons
      highlight = function(ctx)
        local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
        return hl
      end,
    },
  }
end

local insert_blink_source_provider = function(opts, source, module, name, source_opts)
  opts.sources.providers = opts.sources.providers or {}
  opts.sources.providers[source] = {
    name = name or source,
    module = module or "blink.compat.source",
  }

  if source_opts then
    opts.sources.providers[source].opts = source_opts
  end
end

local buffer = {
  name = "Buffer",
  module = "blink.cmp.sources.buffer",
  opts = {
    -- default to all visible buffers
    get_bufnrs = function()
      return vim
        .iter(vim.api.nvim_list_bufs())
        :filter(function(buf)
          return vim.bo[buf].buftype ~= "nofile" or buf_is_big(buf)
        end)
        :totable()
    end,
  },
}

local set_sources_config = function(opts)
  local default_cmp_sources = { "lsp", "path", "snippets", "buffer", "ripgrep" }
  local cmp_sources_by_filetypes = {
    {
      types = { "markdown", "gitcommit" },
      sources = {
        "calc",
        "emoji",
        -- "dictionary",
      },
    },
    {
      types = { "markdown" },
      sources = {
        "pandoc_references",
      },
    },
    {
      types = { "gitcommit" },
      sources = {
        "conventionalcommits",
      },
    },
  }

  local function cmp_sources_for_filetype(filetype)
    local sources_for_filetype = vim.tbl_extend("force", {}, default_cmp_sources)
    for _, entry in ipairs(cmp_sources_by_filetypes) do
      for _, type in ipairs(entry.types) do
        if type == filetype then
          for _, source in ipairs(entry.sources) do
            table.insert(sources_for_filetype, source)
          end
        end
      end
    end

    return sources_for_filetype
  end

  opts.sources.default = function()
    return cmp_sources_for_filetype(vim.bo.filetype)
  end

  opts.sources.cmdline = function()
    local type = vim.fn.getcmdtype()
    -- Search forward and backward
    if type == "/" or type == "?" then
      return { "buffer" }
    end
    -- Commands
    if type == ":" or type == "@" then
      return { "cmdline", "cmdline_history" }
    end
    return {}
  end
end

local set_providers = function(opts, sources)
  for _, source in ipairs(sources) do
    insert_blink_source_provider(opts, source)
  end

  insert_blink_source_provider(opts, "ripgrep", "blink-ripgrep", "Ripgrep", {
    prefix_min_len = 4,
    max_filesize = "200K",
  })
  opts.sources.providers.buffer = buffer
end

-- local set_spelllang_source_config = function(opts)
--   local spelllang = vim.api.nvim_get_option_value("spelllang", { buf = 0 })
--   print('DEBUGPRINT[18]: blink.lua:211: spelllang=' .. vim.inspect(spelllang))
--   if vim.g.neovim_config.cmpDicts[spelllang] ~= nil then
--     local k = vim.g.neovim_config.cmpDicts[spelllang]
--     print("DEBUGPRINT[17]: blink.lua:213: k=" .. vim.inspect(k))
--     insert_blink_source_provider(opts, "dictionary", "blink-cmp-dictionary", "Dict", {
--       get_command = {
--         "rg",
--         "--color=never",
--         "--no-line-number",
--         "--no-messages",
--         "--no-filename",
--         "--ignore-case",
--         "--",
--         "${prefix}", -- this will be replaced by the result of 'get_prefix' function
--         vim.fn.expand(vim.g.neovim_config.cmpDicts[spelllang]), -- where you dictionary is
--       },
--     })
--   end
-- end

local get_nvim_cmp_config = function()
  local nvim_cmp_meta = {
    { "davidsierradz/cmp-conventionalcommits", "conventionalcommits" },
    { "jc-doyle/cmp-pandoc-references", "pandoc_references" },
    { "hrsh7th/cmp-calc", "calc" },
    { "hrsh7th/cmp-emoji", "emoji" },
    { "petertriho/cmp-git", "git" },
    { "dmitmel/cmp-cmdline-history", "cmdline_history" },
  }

  local nvim_cmp_meta_by_index = function(index)
    local deps_per_index = {}
    for _, dep in ipairs(nvim_cmp_meta) do
      table.insert(deps_per_index, dep[index])
    end
    return deps_per_index
  end

  return {
    dependencies = nvim_cmp_meta_by_index(1),
    sources = nvim_cmp_meta_by_index(2),
  }
end

local nvim_cmp_config = get_nvim_cmp_config()

return {
  {
    "saghen/blink.compat",
    opts = {},
    version = not vim.g.lazyvim_blink_main and "*",
  },

  {
    "saghen/blink.cmp",
    dependencies = merge_arrays({
      -- "Kaiser-Yang/blink-cmp-dictionary",
      "mikavilpas/blink-ripgrep.nvim",
    }, nvim_cmp_config.dependencies),
    opts = function(_, opts)
      set_keymap(opts)
      set_quick_select(opts)
      set_providers(opts, nvim_cmp_config.sources)
      set_sources_config(opts)
      -- set_spelllang_source_config(opts)

      opts.signature = { enabled = true }
    end,
  },
}
