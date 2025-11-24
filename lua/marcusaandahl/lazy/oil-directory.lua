return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = {
		{
			"nvim-mini/mini.icons",
			opts = {},
		},
	},
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			use_default_keymaps = false,
			skip_confirm_for_simple_edits = true,
			columns = {
				-- "size", -- Shows file size
				"icon",
			},
			keymaps = {
				["h"] = { "actions.toggle_hidden", mode = "n" },
				["<BS>"] = { "actions.parent", mode = "n" },
				["<CR>"] = "actions.select",
				["<S-CR>"] = {
					callback = function()
						local oil = require("oil")
						local cursor_entry = oil.get_cursor_entry()
						if cursor_entry == nil then
							return
						end
						local full_path = oil.get_current_dir() .. cursor_entry.name
						if cursor_entry.type == "file" then
							vim.cmd("tabnew " .. full_path)
						elseif cursor_entry.type == "directory" then
							vim.cmd("tabnew")
							oil.open(full_path)
						end
					end,
					desc = "Open in new tab",
					mode = "n",
				},
				["<leader>s"] = {
					callback = function()
						require("oil").save({ confirm = true }, nil)
					end,
					desc = "[S]ave oil changes",
				},
				["<leader>S"] = {
					callback = function()
						require("oil").save({ confirm = false }, nil)
					end,
					desc = "[S]ave oil changes (force)",
				},
        ["<C-c>"] = {
          "actions.cd",
          desc = "[C]hange Directory (CD)"
        },
				["<C-r>"] = "actions.refresh",
				["<C-p>"] = { "actions.preview", opts = { vertical = true, split = "botright" } },

				["_"] = { "actions.open_cwd", mode = "n" },
			},
		})
	end,
}
