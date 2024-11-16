-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local lspconfig = require("lspconfig")

local status_ok, clangd_ext = pcall(require, "clangd_extensions")
if status_ok then
  clangd_ext.setup({
    server = lspconfig.clangd,
  })
end
