return {
  "stevearc/overseer.nvim",
  opts = {
    strategy = {
      "terminal",
      use_shell = true,
    },
    templates = { "builtin" },
    task_list = {
      direction = "bottom",
      min_height = 15,
      max_height = 25,
    },
  },
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)

    -- Custom module to save/load project-specific configurations
    local project_tasks = {}
    local last_run = { normal = nil, debug = nil }

    -- Function to get current project root
    local function get_project_root()
      local project_nvim = require("project_nvim.project")
      local root = project_nvim.get_project_root()
      return root or vim.fn.getcwd()
    end

    -- Function to get project config file
    local function get_project_config_file()
      local root = get_project_root()
      return root .. "/.nvim/run_configs.json"
    end

    -- Load project configurations
    local function load_project_configs()
      local config_file = get_project_config_file()
      if vim.fn.filereadable(config_file) == 1 then
        local content = vim.fn.readfile(config_file)
        local ok, configs = pcall(vim.json.decode, table.concat(content, "\n"))
        if ok then
          return configs
        end
      end
      return {}
    end

    -- Save project configurations
    local function save_project_configs(configs)
      local config_file = get_project_config_file()
      local dir = vim.fn.fnamemodify(config_file, ":h")
      vim.fn.mkdir(dir, "p")
      local content = vim.json.encode(configs)
      vim.fn.writefile(vim.split(content, "\n"), config_file)
    end

    -- Add run configuration
    _G.add_run_configuration = function()
      vim.ui.input({ prompt = "Configuration name: " }, function(name)
        if not name or name == "" then return end

        vim.ui.input({ prompt = "Command to run: " }, function(cmd)
          if not cmd or cmd == "" then return end

          vim.ui.select({ "normal", "debug" }, {
            prompt = "Mode: ",
          }, function(mode)
            if not mode then return end

            local configs = load_project_configs()
            configs[name] = {
              cmd = cmd,
              mode = mode,
              created = os.time()
            }
            save_project_configs(configs)
            vim.notify("Run configuration '" .. name .. "' added")
          end)
        end)
      end)
    end

    -- List and run configurations
    _G.list_run_configurations = function()
      local configs = load_project_configs()
      if vim.tbl_isempty(configs) then
        vim.notify("No run configurations found")
        return
      end

      local items = {}
      for name, config in pairs(configs) do
        table.insert(items, {
          name = name,
          cmd = config.cmd,
          mode = config.mode
        })
      end

      vim.ui.select(items, {
        prompt = "Select run configuration:",
        format_item = function(item)
          return string.format("%s [%s]: %s", item.name, item.mode, item.cmd)
        end,
      }, function(choice)
        if choice then
          -- This will be handled by telescope picker with custom mappings
        end
      end)
    end

    -- Run configuration
    _G.run_configuration = function(name, mode)
      local configs = load_project_configs()
      local config = configs[name]
      if not config then
        vim.notify("Configuration '" .. name .. "' not found")
        return
      end

      local task = overseer.new_task({
        cmd = config.cmd,
        name = name,
        strategy = mode == "debug" and {
          "terminal",
          use_shell = true,
          env = { DEBUG = "1" }
        } or {
          "terminal",
          use_shell = true
        },
      })

      task:start()
      last_run[mode] = name
      vim.notify("Running '" .. name .. "' in " .. mode .. " mode")
    end

    -- Re-run last configuration
    _G.rerun_last_configuration = function(mode)
      if last_run[mode] then
        run_configuration(last_run[mode], mode)
      else
        vim.notify("No previous " .. mode .. " run")
      end
    end

    -- Delete run configuration
    _G.delete_run_configuration = function(name)
      local configs = load_project_configs()
      if configs[name] then
        configs[name] = nil
        save_project_configs(configs)
        vim.notify("Configuration '" .. name .. "' deleted")
      end
    end

    -- Edit run configuration
    _G.edit_run_configuration = function(name)
      local configs = load_project_configs()
      local config = configs[name]
      if not config then
        vim.notify("Configuration '" .. name .. "' not found")
        return
      end

      vim.ui.input({ prompt = "Command: ", default = config.cmd }, function(cmd)
        if cmd and cmd ~= "" then
          configs[name].cmd = cmd
          save_project_configs(configs)
          vim.notify("Configuration '" .. name .. "' updated")
        end
      end)
    end
  end,
}
