return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"nvim-telescope/telescope-project.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("project")
			local project_actions = require("telescope._extensions.project.actions")
			require("telescope").setup({
				extensions = {
					project = {
						on_project_selected = function(prompt_bufnr)
							-- Do anything you want in here. For example:
							project_actions.change_working_directory(prompt_bufnr, false)
						end,
					},
					mappings = {
						n = {
							["<C-a>"] = project_actions.add_project_cwd,
							["<C-d>"] = project_actions.delete_project,
							["<C-e>"] = project_actions.rename_project,
							["<C-w>"] = project_actions.change_working_directory,
						},
						i = {
							["<C-a>"] = project_actions.add_project_cwd,
							["<C-d>"] = project_actions.delete_project,
							["<C-e>"] = project_actions.rename_project,
							["<C-w>"] = project_actions.change_working_directory,
						},
					},
				},
			})
		end,
	},
}
