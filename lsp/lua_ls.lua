-- Taken from https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua

---@type vim.lsp.Config
return {
  -- Command and arguments to start the server.
  cmd = { 'lua-language-server' },
  -- Filetypes to automatically attach to.
  filetypes = { 'lua' },
  -- Files that share a root directory will reuse the LSP server connection. Nested are equal.
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  -- Language server specific settings.
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
}
