return {
	'nvim-telescope/telescope.nvim',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ahmedkhalf/project.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    telescope.setup({
      extensions = {
        projects = {
          theme = "dropdown",
          previewer = false,
          initial_mode = "normal",
          mappings = {
            n = {
              ["d"] = function(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  local project = require("project_nvim.project")
                  project.delete_project(selection.value)
                  actions.close(prompt_bufnr)
                  vim.notify("Project deleted: " .. selection.value)
                end
              end,
            },
          },
        },
      },
    })

    telescope.load_extension("projects")

    -- Custom telescope picker for run configurations
    _G.telescope_run_configurations = function()
      local configs = load_project_configs()
      if vim.tbl_isempty(configs) then
        vim.notify("No run configurations found")
        return
      end

      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local conf = require("telescope.config").values

      local entries = {}
      for name, config in pairs(configs) do
        table.insert(entries, {
          name = name,
          cmd = config.cmd,
          mode = config.mode,
          display = string.format("%s [%s]: %s", name, config.mode, config.cmd)
        })
      end

      pickers.new({}, {
        prompt_title = "Run Configurations",
        finder = finders.new_table({
          results = entries,
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.display,
              ordinal = entry.name,
            }
          end,
        }),
        sorter = conf.generic_sorter({}),
        initial_mode = "normal",
        attach_mappings = function(prompt_bufnr, map)
          -- Run in normal mode
          map("n", "n", function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if selection then
              run_configuration(selection.value.name, "normal")
            end
          end)

          -- Run in debug mode
          map("n", "d", function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if selection then
              run_configuration(selection.value.name, "debug")
            end
          end)

          -- Delete configuration
          map("n", "D", function()
            local selection = action_state.get_selected_entry()
            if selection then
              delete_run_configuration(selection.value.name)
              actions.close(prompt_bufnr)
            end
          end)

          -- Change/edit configuration
          map("n", "C", function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if selection then
              edit_run_configuration(selection.value.name)
            end
          end)

          -- Add new configuration
          map("n", "A", function()
            actions.close(prompt_bufnr)
            add_run_configuration()
          end)

          return true
        end,
      }):find()
    end
  end,
}
