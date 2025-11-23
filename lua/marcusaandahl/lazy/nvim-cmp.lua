return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		-- nvim-cmp base dependencies
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		-- Snippet dependencies
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				-- Better Snippet Visuals
				"onsails/lspkind.nvim",
			},
			opts = {},
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},
	event = "InsertEnter",
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- Standard
				{ name = "luasnip" }, -- Snippets
				{ name = "buffer" }, -- Text within current buffer
				{ name = "path" }, -- File System Path
			}),
			snippet = {
				expand = function(args)
					luasnip.expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					max_height = 20, -- Show max 20 items at once
				}),
				documentation = cmp.config.window.bordered(),
			},
			performance = {
				max_view_entries = 30, -- Limits to finding 30 suggestions - tune if need be
			},
			completion = {
				completeopt = "menu,menuone,noinsert,preview",
			},
			preselect = cmp.PreselectMode.None,
			mapping = {
				-- Go to next
				["<Up>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				-- Go to previous
				["<Down>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					elseif luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),
				-- Insert if selected, otherwise use first selection
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if not cmp.get_selected_entry() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						end
						cmp.confirm({ select = true })
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-Up>"] = cmp.mapping.scroll_docs(-4),
				["<C-Down>"] = cmp.mapping.scroll_docs(4),
				-- Close suggestions
				["<Esc>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.close()
					else
						fallback()
					end
				end, { "i" }),
				-- Toggle see documentation
				["<C-d>"] = cmp.mapping(function()
					if cmp.visible_docs() then
						cmp.close_docs()
					else
						cmp.open_docs()
					end
				end, { "i", "s" }),
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					show_labelDetails = true, -- Show more info
					before = function(entry, vim_item)
						-- Show source name
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
						})[entry.source.name]
						return vim_item
					end,
				}),
			},
		})
	end,
}
