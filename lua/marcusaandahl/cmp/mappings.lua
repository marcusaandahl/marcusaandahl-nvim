local M = {}

M.setup = function(cmp, luasnip)
  return {
    -- Goes to next suggestion if any
    ['<Down>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end, { 'i' }),
    
    -- Goes to previous suggestion if any
    ['<Up>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end, { 'i' }),
    
    -- Tab accepts suggestion if any selected - accepts first one otherwise
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if not cmp.get_selected_entry() then
          -- No selection yet, select first and confirm
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        end
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Closes suggestions
    ['<Esc>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.abort()  -- or use cmp.close()
      else
        fallback()  -- Let Escape work normally (exit insert mode)
      end
    end, { 'i' }),
  }
end

return M
