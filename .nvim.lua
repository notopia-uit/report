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
    formatterMode = "typstyle",
    formatterProseWrap = false,
    formatterPrintWidth = 120,
    formatterIndentSize = 4,
  },
}

vim.lsp.config.texlab = {
  settings = {
    texlab = {
      formatterLineLength = 120,
    },
  },
}
