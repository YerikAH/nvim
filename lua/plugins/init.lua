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

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      renderer = {
        highlight_git = false,
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false,
            modified = false,
            hidden = false,
            diagnostics = false,
            bookmarks = false,
          },
          web_devicons = {
            file = { enable = false, color = false },
            folder = { enable = false, color = false },
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "󰆤",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "●",
              staged = "●",
              unmerged = "●",
              renamed = "➜",
              untracked = "●",
              deleted = "✖",
              ignored = "◌",
            },
          },
        },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = " ",
        disable_devicons = true,
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
      pickers = {
        find_files = { disable_devicons = true },
        git_files = { disable_devicons = true },
        oldfiles = { disable_devicons = true },
        live_grep = { disable_devicons = true },
        grep_string = { disable_devicons = true },
        buffers = { disable_devicons = true },
      },
      extensions_list = { "themes", "terms" },
      extensions = {},
    },
  },
}
