-- vi: ft=lua

---@class GroupDef
---@field create_function nil | fun()
---@field create_options nil | fun(): table<string, any>
---@field create_condition fun(options: table<string, any>): boolean

---@class GroupList
---@field all fun(group:string )
---@field today fun(group:string )
---@field this_week fun(group:string )
---@field this_month fun(group:string )
---@field tags fun() | nil

---@class GroupEdit
---@field last_modified fun(group: string | nil)

---@class ZkGroupUtils
---@field groups table<string, GroupDef>
---@field create table<string, fun()>
---@field list GroupList | table<string, GroupList>
---@field edit GroupEdit | table<string, GroupEdit>

---@type ZkGroupUtils
local zk_group_utils = {
  groups = {
    tasks = {
      create_options = function()
        return {
          dir = "tasks",
          title = vim.fn.input({ prompt = "Title: " }),
        }
      end,
      create_condition = function(options)
        return #options.title > 0
      end,
    },
    wiki = {
      create_options = function()
        return {
          dir = "wiki",
          title = vim.fn.input({ prompt = "Title: " }),
        }
      end,
      create_condition = function(options)
        return #options.title > 0
      end,
    },
    dailies = {
      create_options = function()
        return {
          dir = "dailies",
        }
      end,
      create_condition = function()
        return true
      end,
    },
    tickets = {
      create_function = function()
        local ticket_nr = vim.fn.input("Ticket Id: PRO-")
        local ticket_id = "PRO-" .. ticket_nr

        vim.notify("Fetching Ticket: " .. ticket_id, vim.log.levels.INFO)
        vim.fn.jobstart("fetch-jira-ticket " .. ticket_nr, {
          on_exit = function()
            local jsonContent = vim.fn.readfile(vim.env["HOME"] .. "/.jira-tickets/" .. ticket_id .. ".json")
            local jsonData = vim.fn.json_decode(jsonContent)
            require("zk").new({
              title = jsonData.branch,
              dir = "tickets",
              extra = jsonData,
            })
          end,
        })
      end,
      create_condition = function()
        return false
      end,
    },
  },
  create = {
    default = function()
      require("zk").new({
        title = vim.fn.input({ prompt = "Title: " }),
      })
    end,
  },
  list = {},
  edit = {
    last_modified = function(group)
      local command
      local msg
      if group then
        command = "find $ZK_NOTEBOOK_DIR/" .. group .. " -mtime 0 -type f | tail -1"
        msg = "No last modified file found in " .. group .. "."
      else
        command = "find $ZK_NOTEBOOK_DIR/ -mtime 0 -type f | tail -1"
        msg = "No last modified file found"
      end

      ---@diagnostic disable-next-line: undefined-field
      local last_modified_file = os.capture(command)
      if last_modified_file then
        local stat = vim.uv.fs_stat(last_modified_file)
        if stat and stat.type == "file" then
          return vim.cmd("edit " .. last_modified_file)
        end
      end
      vim.notify(msg, vim.log.levels.INFO)
    end,
  },
}

-- set zk_util.{create,edit,list}
for key, group in pairs(zk_group_utils.groups) do
  if type(group) == "table" then
    -- zk_util.create
    zk_group_utils.create[key] = function()
      if zk_group_utils.groups[key].create_function then
        zk_group_utils.groups[key].create_function()
      else
        local options = group.create_options()
        if group.create_condition(options) then
          require("zk").new(options)
        end
      end
    end

    -- zk_util.edit
    zk_group_utils.edit[key] = {
      last_modified = function()
        zk_group_utils.edit.last_modified(key)
      end,
    }

    -- zk_util.list
    zk_group_utils.list[key] = {
      all = function()
        require("telescope").load_extension("zk").notes({ hrefs = { key } })
      end,
      today = function()
        require("telescope").load_extension("zk").notes({ hrefs = { key }, created_after = "today" })
      end,
      this_week = function()
        require("telescope").load_extension("zk").notes({ hrefs = { key }, created_after = "1 week ago" })
      end,
      this_month = function()
        require("telescope").load_extension("zk").notes({ hrefs = { key }, created_after = "1 month ago" })
      end,
    }
    zk_group_utils.list.all = function()
      require("telescope").load_extension("zk").notes()
    end
    zk_group_utils.list.today = function()
      require("telescope").load_extension("zk").notes({ created_after = "today" })
    end
    zk_group_utils.list.this_week = function()
      require("telescope").load_extension("zk").notes({ created_after = "1 week ago" })
    end
    zk_group_utils.list.this_month = function()
      require("telescope").load_extension("zk").notes({ created_after = "1 month ago" })
    end
    zk_group_utils.list.tags = function()
      require("telescope").load_extension("zk").tags()
    end
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mickael-menu/zk-nvim",
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "mickael-menu/zk-nvim",
      event = "VeryLazy",
      config = function()
        require("lazyvim.util").on_load("telescope.nvim", function()
          require("telescope").load_extension("zk")
        end)
      end,
    },
  },

  {
    "mickael-menu/zk-nvim",
    cond = function()
      if not vim.env.ZK_NOTEBOOK_DIR then
        return false
      end
      return vim.fs.dirname(vim.env.ZK_NOTEBOOK_DIR) ~= nil
    end,
    keys = {
      { "<leader>n", "", desc = "+notes" },
      { "<leader>nt", "", desc = "+tasks" },
      { "<leader>nw", "", desc = "+wiki" },
      { "<leader>ni", "", desc = "+tickets" },
      { "<leader>nd", "", desc = "+dailies" },
      { "<leader>na", zk_group_utils.list.all, desc = "List all" },
      { "<leader>nx", zk_group_utils.list.tags, desc = "List tags" },
      { "<leader>nT", zk_group_utils.list.today, desc = "List today" },
      { "<leader>nw", zk_group_utils.list.this_week, desc = "List this week" },
      { "<leader>nm", zk_group_utils.list.this_month, desc = "List this month" },
      { "<leader>nl", zk_group_utils.edit.last_modified, desc = "Edit last modified" },
      { "<leader>nc", zk_group_utils.create.default, desc = "Create Default Note" },

      { "<leader>nta", zk_group_utils.list.tasks.all, desc = "List all" },
      { "<leader>ntt", zk_group_utils.list.tasks.today, desc = "List today" },
      { "<leader>ntw", zk_group_utils.list.tasks.this_week, desc = "List this week" },
      { "<leader>ntm", zk_group_utils.list.tasks.this_month, desc = "List this month" },
      { "<leader>ntl", zk_group_utils.edit.tasks.last_modified, desc = "Edit last modified" },
      { "<leader>ntc", zk_group_utils.create.tasks, desc = "Create Task" },

      { "<leader>nwa", zk_group_utils.list.wiki.all, desc = "List all" },
      { "<leader>nwt", zk_group_utils.list.wiki.today, desc = "List today" },
      { "<leader>nww", zk_group_utils.list.wiki.this_week, desc = "List this week" },
      { "<leader>nwm", zk_group_utils.list.wiki.this_month, desc = "List this month" },
      { "<leader>nwl", zk_group_utils.edit.wiki.last_modified, desc = "Edit last modified" },
      { "<leader>nwc", zk_group_utils.create.wiki, desc = "Create Wiki" },

      { "<leader>nia", zk_group_utils.list.tickets.all, desc = "List all" },
      { "<leader>nit", zk_group_utils.list.tickets.today, desc = "Today" },
      { "<leader>niw", zk_group_utils.list.tickets.this_week, desc = "List this week" },
      { "<leader>nim", zk_group_utils.list.tickets.this_month, desc = "List this month" },
      { "<leader>nil", zk_group_utils.edit.tickets.last_modified, desc = "Edit last modified" },
      { "<leader>nic", zk_group_utils.create.tickets, desc = "Create ticket" },

      { "<leader>nda", zk_group_utils.list.dailies.all, desc = "List all" },
      { "<leader>ndt", zk_group_utils.list.dailies.today, desc = "List today" },
      { "<leader>ndw", zk_group_utils.list.dailies.this_week, desc = "List this week" },
      { "<leader>ndm", zk_group_utils.list.dailies.this_month, desc = "List this month" },
      { "<leader>ndl", zk_group_utils.edit.dailies.last_modified, desc = "Edit last modified" },
      { "<leader>ndc", zk_group_utils.create.dailies, desc = "Create or Edit Daily" },

      -- {
      -- 	"<leader>nc",
      -- 	function()
      -- 		require("zk.commands").get("ZkCreateFromTitleSelection")({
      -- 			extra = { branch = vim.fn.input("Branch: ") },
      -- 			dir = "tickets",
      -- 		})
      -- 	end,
      -- 	desc = "Create ticket note",
      -- 	mode = { "v" },
      -- },
    },
  },
}
