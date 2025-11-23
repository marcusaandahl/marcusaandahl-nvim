return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			lua = { "luacheck" }, -- Installed using luarocks manually
			javascript = { "eslint" }, -- Installed using npm automatically via mason
			typescript = { "eslint" }, -- Installed using npm automatically via mason
		}
	end,
}
