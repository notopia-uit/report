---@module 'lazy'
---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        typst = { "typstyle" },
      },
      formatters = {
        typstyle = {
          append_args = {
            "--line-width=80",
            "--indent-width=2",
            "--wrap-text",
          },
        },
      },
    },
    optional = true,
  },
}
