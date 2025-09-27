vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "FocusLost", "BufLeave" }, {
  pattern = "*",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
    local modified = vim.api.nvim_buf_get_option(buf, "modified")
    
    -- Only save normal buffers that are modified
    if buftype == "" and modified then
      vim.cmd("silent! write")
    end
  end,
  desc = "Auto-save files",
})
