local function buf_is_big(bufnr)
  local max_filesize = 100 * 1024 -- 100 KB
  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
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

local add_provider = function(opts, key, sourceProps)
  opts.sources.providers = opts.sources.providers or {}
  opts.sources.providers[key] = sourceProps
end

local add_compat_provider = function(opts, key, sourceProps)
  add_provider(
    opts,
    key,
    vim.tbl_extend("force", {
      name = key,
      module = "blink.compat.source",
    }, sourceProps)
  )
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
    min_keyword_length = 4,
    score_offset = 2,
  },
}

local set_sources_config = function(opts)
  local default_cmp_sources = { "lsp", "path", "snippets", "buffer", "ripgrep" }
  local cmp_sources_by_filetypes = {
    {
      types = { "markdown", "gitcommit", "typst" },
      sources = {
        "calc",
        "emoji",
        "dictionary",
      },
    },
    {
      types = { "markdown" },
      sources = {
        -- "pandoc_references",
      },
    },
    {
      types = { "gitcommit" },
      sources = {
        "conventional_commits",
        -- "git",
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

  opts.cmdline = {
    enabled = true,
    sources = function()
      local type = vim.fn.getcmdtype()
      -- Search forward and backward
      if type == "/" or type == "?" then
        return { "buffer" }
      end
      -- Commands
      if type == ":" or type == "@" then
        return { "cmdline", "path" }
      end
      return {}
    end,
  }
end

local set_providers = function(opts, nvim_cmp_config_sources)
  for _, cmp_source in ipairs(nvim_cmp_config_sources) do
    add_compat_provider(opts, cmp_source, {})
  end

  add_provider(opts, "ripgrep", {
    module = "blink-ripgrep",
    name = "Ripgrep",
    enabled = #vim.fs.find(".git", { path = LazyVim.root.get(), upward = true }) > 0,
    min_keyword_length = 3,
    opts = {
      max_filesize = "200K",
      prefix_min_len = 3,
    },
  })

  add_provider(opts, "conventional_commits", {
    name = "Conventional Commits",
    module = "blink-cmp-conventional-commits",
    enabled = function()
      return vim.bo.filetype == "gitcommit"
    end,
    opts = {},
  })

  -- add_provider(opts, "references", {
  --   name = "pandoc_references",
  --   module = "cmp-pandoc-references.blink",
  -- })

  -- add_provider(opts, "git", {
  --   module = "blink-cmp-git",
  --   name = "Git",
  --   opts = {},
  -- })

  add_provider(opts, "emoji", {
    module = "blink-emoji",
    name = "Emoji",
    opts = { insert = true },
  })

  add_provider(opts, "dictionary", {
    module = "blink-cmp-dictionary",
    name = "Dict",
    min_keyword_length = 3,
    opts = {
      dictionary_files = function()
        local spelllang = vim.api.nvim_get_option_value("spelllang", { buf = 0 })
        if
          vim.g.lixim_config.cmpDicts ~= nil
          and spelllang ~= nil
          and vim.g.lixim_config.cmpDicts[spelllang] ~= nil
        then
          return { vim.g.lixim_config.cmpDicts[spelllang] }
        end
        return {}
      end,
    },
  })

  opts.sources.providers.buffer = buffer

  opts.sources.providers.path = opts.sources.providers.path or {}
  opts.sources.providers.path.score_offset = 40

  opts.sources.providers.snippets = opts.sources.providers.snippets or {}
  opts.sources.providers.snippets.score_offset = 3
  opts.sources.providers.snippets.min_keyword_length = 2
  opts.sources.providers.snippets.min_keyword_length = 2
  opts.sources.providers.snippets.opts = opts.sources.providers.snippets.opts or {}
  opts.sources.providers.snippets.opts.search_paths = { snippets_path() }

  opts.sources.providers.lsp = opts.sources.providers.lsp or {}
  opts.sources.providers.lsp.score_offset = 4
  opts.sources.providers.snippets.min_keyword_length = 0
end

local get_nvim_cmp_config = function()
  local nvim_cmp_meta = {
    { "hrsh7th/cmp-calc", "calc" },
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
      "Kaiser-Yang/blink-cmp-dictionary",
      "mikavilpas/blink-ripgrep.nvim",
      "disrupted/blink-cmp-conventional-commits",
      -- "jmbuhr/cmp-pandoc-references",
      -- {
      --   "Kaiser-Yang/blink-cmp-git",
      --   dependencies = { "nvim-lua/plenary.nvim" },
      -- },
      "moyiz/blink-emoji.nvim",
    }, nvim_cmp_config.dependencies),
    opts = function(_, opts)
      set_keymap(opts)
      set_quick_select(opts)
      set_providers(opts, nvim_cmp_config.sources)
      set_sources_config(opts)

      opts.signature = { enabled = true }
      opts.completion.list = opts.completion.list or {}
      opts.completion.list.selection = {
        preselect = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
        auto_insert = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
      }
    end,
  },
}
