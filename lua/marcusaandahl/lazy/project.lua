-- Project management
return  {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      -- Manual mode to control which directories are projects
      manual_mode = true,
      -- Detection methods
      detection_methods = { "pattern" },
      -- Patterns to detect project root
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
      -- Show hidden files in telescope
      show_hidden = false,
      -- Silent mode
      silent_chdir = true,
      -- Scope chdir
      scope_chdir = 'global',
      -- Path to store project history
      datapath = vim.fn.stdpath("data"),
    })
  end,
}
