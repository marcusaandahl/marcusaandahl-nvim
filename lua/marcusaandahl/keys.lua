local wk = require("which-key")
wk.add({
  { "<leader>f", group = "[F]iles" }, -- Group
  { "<leader>w", group = "[W]ords" }, -- Group
  { "<leader>g", group = "[G]it" }, -- Group
  { "<leader>p", group = "[P]rojects" } -- Group
})

-- Telescope Files
local builtin_telescope = require "telescope.builtin"
vim.keymap.set("n", "<leader>fa", builtin_telescope.find_files, { desc = "[F]iles [A]ll" })
vim.keymap.set("n", "<leader>fg", builtin_telescope.git_files, { desc = "[F]iles [G]it" })
vim.keymap.set("n", "<leader>fp", builtin_telescope.oldfiles, { desc = "[F]iles [P]reviously opened" })
-- Telescope Words
vim.keymap.set("v", "<leader>s", builtin_telescope.grep_string, { desc = "[S]earch Word" })
vim.keymap.set("n", "<leader>wl", builtin_telescope.live_grep, { desc = "[W]ord [L]ive Search" })
-- Telescope Git
vim.keymap.set("n", "<leader>gc", builtin_telescope.git_commits, { desc = "[G]it [C]ommits" })
vim.keymap.set("n", "<leader>gb", builtin_telescope.git_branches, { desc = "[G]it [B]ranches" })
vim.keymap.set("n", "<leader>gs", builtin_telescope.git_status, { desc = "[G]it [S]tatus" })
-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndo Tree" })
-- Neotree
vim.keymap.set("n", '<leader>ft', '<Cmd>Neotree toggle<CR>', { desc = "[F]iles [T]ree" })
-- Oil
-- vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
require("oil").setup({
  use_default_keymaps = false,
  keymaps = {
    -- Backspace goes to parent directory
    ["<BS>"] = "actions.parent",
    
    -- Enter to select (go into directory or open file)
    ["<CR>"] = "actions.select",

    ["h"] = "actions.toggle_hidden",
    
    -- Leader+s to save changes
    ["<leader>s"] = {
      callback = function()
        require("oil").save()
      end,
      desc = "Save oil changes"
    },
    
    -- Leader+q to quit without saving
    ["<leader>q"] = {
      callback = function()
        require("oil").close()
      end,
      desc = "Quit oil without saving"
    },
  }
})
vim.keymap.set("n", "<leader>d", "<CMD>Oil<CR>", { desc = "[D]irectory" })
-- Neovim Project
local project = require("neovim-project")
-- List projects
vim.keymap.set("n", "<leader>pl", function()
  project.open_project(nil, {
    sort_by = "recent",
    action = "find_files"
  })
end, { desc = "[P]rojects [L]ist" })
-- Add project
vim.keymap.set("n", "<leader>pa", function()
  project.add_project_manually()
end, { desc = "[P]rojects [A]dd" })
-- Delete project
vim.keymap.set("n", "<leader>pd", function()
  project.delete_project()
end, { desc = "[P]rojects [D]elete" })

-- For grouping projects, you can use custom picker actions:
-- vim.keymap.set("n", "<leader>pg", function()
  -- -- Group projects by custom criteria
  -- project.open_project(nil, {
    -- -- You can modify the picker display to group projects
    -- -- This requires customizing the telescope picker
    -- attach_mappings = function(prompt_bufnr, map)
      -- local actions = require("telescope.actions")
      -- local action_state = require("telescope.actions.state")
      -- 
      -- -- Custom action for grouping logic
      -- map("i", "<C-g>", function()
        -- -- Implement your grouping logic here
        -- print("Grouping projects...")
      -- end)
      -- 
      -- return true
    -- end,
  -- })
-- end, { desc = "[P]rojects [G]roups" })
