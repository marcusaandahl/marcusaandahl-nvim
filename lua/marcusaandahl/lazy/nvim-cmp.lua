return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Snippet engine (required)
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    
    -- Completion sources
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    
    -- Optional
    "hrsh7th/cmp-nvim-lsp-signature-help",  -- Function signatures
    "hrsh7th/cmp-nvim-lua",                  -- Neovim Lua API
    "hrsh7th/cmp-emoji",                     -- Emoji completion
    "f3fora/cmp-spell",                      -- Spell checking

    -- Optional: for better appearance
    "onsails/lspkind.nvim",
  },
  config = function()
    require("marcusaandahl.cmp").setup()
  end,
}
