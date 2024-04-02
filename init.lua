-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local lspconfig = require("lspconfig")
--- settings: the settings to pass to the language server (server-specific setting, instead of lsp client)
-- pyright settings reference: https://github.com/microsoft/pyright/blob/main/docs/settings.md
lspconfig.pyright.setup({ settings = { python = { analysis = { typeCheckingMode = "basic" } } } })

lspconfig.clangd.setup({ capabilities = { offsetEncoding = "utf-8" } })

lspconfig.rust_analyzer.setup({})
