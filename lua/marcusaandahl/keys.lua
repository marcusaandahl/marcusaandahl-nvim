local wk = require("which-key")
wk.add({
  { "<leader>f", group = "[F]iles" }, -- Group
  { "<leader>w", group = "[W]ords" }, -- Group
  { "<leader>g", group = "[G]it" }, -- Group
  { "<leader>gt", group = "[G]it [T]elescope" }, -- Group
  { "<leader>r", group = "[R]un Configurations" }, -- Group
  { "<leader>p", group = "[P]rojects" } -- Group
})

local keymap = vim.keymap.set

-- Telescope Files
local builtin_telescope = require "telescope.builtin"
keymap("n", "<leader>fa", builtin_telescope.find_files, { desc = "[F]iles [A]ll" })
keymap("n", "<leader>fg", builtin_telescope.git_files, { desc = "[F]iles [G]it" })
keymap("n", "<leader>fp", builtin_telescope.oldfiles, { desc = "[F]iles [P]reviously opened" })
-- Telescope Words
keymap("v", "<leader>s", builtin_telescope.grep_string, { desc = "[S]earch Word" })
keymap("n", "<leader>wl", builtin_telescope.live_grep, { desc = "[W]ord [L]ive Search" })
-- Telescope Git
keymap("n", "<leader>gtc", builtin_telescope.git_commits, { desc = "[G]it [T]elescope [C]ommits" })
keymap("n", "<leader>gtb", builtin_telescope.git_branches, { desc = "[G]it [T]elescope [B]ranches" })
keymap("n", "<leader>gts", builtin_telescope.git_status, { desc = "[G]it [T]elescope [S]tatus" })
-- Git
keymap("n", "<leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus" })
keymap("n", "<leader>gvd", ":Gvdiff<CR>", { desc = "[G]it [V]ertical [D]ifference" })
keymap("n", "<leader>ga", ":Gwrite<CR>", { desc = "[G]it [A]dd file" })
keymap("n", "<leader>gr", ":Gread<CR>", { desc = "[G]it [R]eset file to last commit" })
keymap("n", "<leader>gl", ":Git log<CR>", { desc = "[G]it [L]og commit history" })
keymap("n", "<leader>gb", ":Git blame<CR>", { desc = "[G]it [B]lame" })
keymap("n", "<leader>gc", ":Git commit<CR>", { desc = "[G]it [C]ommit" })
-- Undotree
keymap("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndo Tree" })
-- Neotree
keymap("n", '<leader>ft', '<Cmd>Neotree toggle<CR>', { desc = "[F]iles [T]ree" })
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
keymap("n", "<leader>d", "<CMD>Oil<CR>", { desc = "[D]irectory" })
-- Project management keymaps
keymap("n", "<leader>pl", "<cmd>Telescope projects<cr>", { desc = "[P]rojects [L]ist" })
keymap("n", "<leader>pa", function()
  require("project_nvim.project").add_project(vim.fn.getcwd())
  vim.notify("Project added: " .. vim.fn.getcwd())
end, { desc = "[P]rojects [A]dd CWD" })

-- Run configuration keymaps
keymap("n", "<leader>rl", telescope_run_configurations, { desc = "[R]un configurations [L]ist" })
keymap("n", "<leader>rn", function() rerun_last_configuration("normal") end, { desc = "[R]un last (normal)" })
keymap("n", "<leader>rd", function() rerun_last_configuration("debug") end, { desc = "[R]un last (debug)" })
keymap("n", "<leader>ra", add_run_configuration, { desc = "[R]un configurations [A]dd" })

-- Debug keymaps
keymap("n", "<S-d>", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })
