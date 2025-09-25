-- Setup LSP
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
  }
})

-- Setup linting
require("conform").setup({
  default_format_opts = { lsp_format = "fallback" },
  formatters_by_ft = {
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
  }
})
