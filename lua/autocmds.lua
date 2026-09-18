require "nvchad.autocmds"

-- jsonc usa el parser JSON porque Tree-sitter no distribuye un parser separado.
vim.treesitter.language.register("json", "jsonc")
