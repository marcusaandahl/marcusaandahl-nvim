return {
  "coffebar/neovim-project",
  opts = {
    projects = {
      -- project roots
      -- TODO: Add ITU
    },
    dashboard_mode = "hyper",
    sort_by = "recent",
    patterns = { ".git" }, -- Will add projects if root contains .git
    datapath = "~/.local/share/nvim/neovim-project",
    last_session_on_startup = false,
    picker = {
      type = "telescope",

      preview = {
        enabled = true,
        git_status = true,
        git_fetch = false,
        show_hidden = true
      }
    }
  },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" }, -- picker
    { "Shatur/neovim-session-manager" } -- session manager
  },
  lazy = false,
  priority = 100,
}
