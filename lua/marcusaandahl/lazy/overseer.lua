return {
  'stevearc/overseer.nvim',
  dependencies = {
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
  },
  config = function()
    require('overseer').setup({
      -- Enable DAP integration
      dap = true,
      
      templates = { 
        "builtin",
        "user.debug_tasks", -- Custom debug templates
        "vscode.load_launch_json" -- Load VSCode configurations
      },
      
      component_aliases = {
        default_debug = {
          "on_output_quickfix",
          "on_exit_set_status",
          "on_complete_notify",
          "dap",  -- This enables DAP integration
        },
      },
    })
  end
}
