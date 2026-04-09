vim.lsp.config.tinymist = {
  settings = {
    fontPaths = {
      "./src/assets/fonts/",
    },
    projectResolution = "lockDatabase",
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
