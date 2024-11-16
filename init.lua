-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
  cmd = {
    "/usr/bin/clangd-12",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  root_dir = function(fname)
    return lspconfig.util.root_pattern(
      "Makefile",
      "configure.ac",
      "configure.in",
      "config.h.in",
      "meson.build",
      "meson_options.txt",
      "build.ninja"
    )(fname) or lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt")(fname) or lspconfig.util.find_git_ancestor(
      fname
    )
  end,
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
  on_attach = function(client, bufnr)
    -- Keymap for switching between source and header files
    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "<leader>ch",
      "<cmd>ClangdSwitchSourceHeader<cr>",
      { noremap = true, silent = true, desc = "Switch Source/Header (C/C++)" }
    )
  end,
})

-- Optional: Handling clangd_extensions setup, if required
local status_ok, clangd_ext = pcall(require, "clangd_extensions")
if status_ok then
  clangd_ext.setup({
    server = lspconfig.clangd,
  })
end
