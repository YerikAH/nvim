return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "astro-language-server",
        "basedpyright",
        "black",
        "css-lsp",
        "emmet-language-server",
        "eslint-lsp",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "prettier",
        "ruff",
        "stylua",
        "tailwindcss-language-server",
        "typescript-language-server",
        "yaml-language-server",
        "isort",
      },
      run_on_start = true,
      start_delay = 0,
    },
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "astro",
        "bash",
        "css",
        "csv",
        "dockerfile",
        "gitignore",
        "graphql",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "scss",
        "tsx",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      auto_install = true,
    },
  },
}
