return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
        "scala",
        "rust",
        "regex",
        "java",
        "scala",
        "python",
        "svelte",
        "javascript",
        "typescript",
        "css",
        "html",
        "markdown",
        "bash"
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
			},
			additional_vim_regex_highlighting = false,
		})
	end,
}
