return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		require("mini.move").setup({
			mappings = {
				-- Move visual selection in Visual mode
				left = "<C-h>",
				right = "<C-l>",
				down = "<C-j>",
				up = "<C-k>",

				-- Move current line in Normal mode
				line_left = "<C-h>",
				line_right = "<C-l>",
				line_down = "<C-j>",
				line_up = "<C-k>",
			},

			options = {
				reindent_linewise = true, -- Automatically reindent
			},
		})
	end,
}
