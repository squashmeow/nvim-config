return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        clangd = {
          cmd = {
            "clangd-12",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--offset-encoding=utf-16",
          },
        },
      },
    },
  },
}
