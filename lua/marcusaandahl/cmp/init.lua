local M = {}

-- Separate file for mappings
M.get_mappings = function()
  return require("marcusaandahl.cmp.mappings")
end

-- Separate file for sources
M.get_sources = function()
  return require("marcusaandahl.cmp.sources")
end

-- Main setup function
M.setup = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = M.get_mappings().setup(cmp, luasnip),
    sources = M.get_sources(),
  })
end

return M
