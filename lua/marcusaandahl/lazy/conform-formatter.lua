return {
  'stevearc/conform.nvim',
  event = {
    "BufReadPre",
    "BufNewFile"
  },
  opts = {},
  config = function()
		-- Formatters using conform
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
		})
  end
}
