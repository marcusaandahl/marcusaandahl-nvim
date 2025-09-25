
local wk = require("which-key")
wk.add({
  { "<leader>f", group = "[F]iles" }, -- Group
  { "<leader>w", group = "[W]ords" }, -- Group
  { "<leader>g", group = "[G]it" }, -- Group
  { "<leader>cd", group = "[C]hange [D]irectory" }, -- Group
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
vim.keymap.set("n", '<leader>d', '<Cmd>Neotree toggle<CR>', { desc = "[D]irecetory Toggle" })
-- Oil
require("oil").setup({
  use_default_keymaps = false,
  keymaps = {
    -- Backspace goes to parent directory
    ["<BS>"] = "actions.parent",
    
    -- Enter to select (go into directory or open file)
    ["<CR>"] = "actions.select",
    
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
vim.keymap.set("n", "<leader>fc", "<CMD>Oil<CR>", { desc = "[F]iles [C]hange" })
