require("nvchad.configs.lspconfig").defaults()

local servers = {
  "astro",
  "basedpyright",
  "cssls",
  "emmet_language_server",
  "eslint",
  "html",
  "jsonls",
  "lua_ls",
  "ruff",
  "tailwindcss",
  "ts_ls",
  "yamlls",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
