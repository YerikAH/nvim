local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    astro = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    less = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    ["markdown.mdx"] = { "prettier" },
    graphql = { "prettier" },
    vue = { "prettier" },
    svelte = { "prettier" },
    python = { "isort", "black" },
  },

  format_on_save = {
    timeout_ms = 3000,
    lsp_format = "fallback",
  },

  notify_on_error = true,
  notify_no_formatters = false,
}

return options
