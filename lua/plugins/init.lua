local function rounded_telescope_titles(prompt_bufnr, map)
  map("n", "q", require("telescope.actions").close)

  vim.schedule(function()
    local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)

    local function rounded(title)
      if not title or title == false then
        return title
      end

      title = tostring(title):gsub("^%s+", ""):gsub("%s+$", "")
      return "  " .. title .. "  "
    end

    for _, section in ipairs { "prompt", "results", "preview" } do
      local window = picker.layout and picker.layout[section]
      local title = picker[section .. "_title"]

      if window and window.border and title then
        window.border:change_title(rounded(title))
      end
    end
  end)

  return true
end

return {
  {
    "stevearc/conform.nvim",
    lazy = false,
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
      filters = {
        git_ignored = true,
        dotfiles = false,
        exclude = { "/%.env[^/]*$" },
      },
      view = {
        preserve_window_proportions = true,
        signcolumn = "no",
        width = {
          min = 32,
          max = function()
            return math.max(36, math.min(55, math.floor(vim.o.columns * 0.4)))
          end,
          padding = 2,
        },
      },
      renderer = {
        full_name = true,
        group_empty = true,
        indent_width = 1,
        highlight_git = false,
        icons = {
          show = {
            file = false,
            folder = true,
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
        dynamic_preview_title = false,
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
        find_files = { disable_devicons = true, attach_mappings = rounded_telescope_titles },
        git_files = { disable_devicons = true, attach_mappings = rounded_telescope_titles },
        oldfiles = { disable_devicons = true, attach_mappings = rounded_telescope_titles },
        live_grep = { disable_devicons = true, attach_mappings = rounded_telescope_titles },
        grep_string = { disable_devicons = true, attach_mappings = rounded_telescope_titles },
        buffers = { disable_devicons = true, attach_mappings = rounded_telescope_titles },
      },
      extensions_list = { "themes", "terms" },
      extensions = {},
    },
  },
}
