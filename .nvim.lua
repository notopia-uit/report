vim.lsp.config.tinymist = {
  settings = {
    fontPaths = {
      "./src/assets/fonts/",
    },
    lint = {
      enabled = true,
    },
    preview = {
      refresh = "onSave",
    },
  },
}

vim.lsp.config.texlab = {
  settings = {
    texlab = {
      formatterLineLength = 120,
    },
  },
}
