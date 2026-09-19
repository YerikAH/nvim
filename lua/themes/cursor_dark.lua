-- Cursor Dark inspired theme for NvChad/Base46.
-- Based on the VS Code Dark palette, with Cursor-like panel and accent colors.
local M = require("base46.themes.vscode_dark")

M.base_30 = vim.tbl_deep_extend("force", M.base_30, {
  white = "#D4D4D4",
  darker_black = "#141414",
  black = "#181818",
  black2 = "#1E1E1E",
  one_bg = "#252526",
  one_bg2 = "#2D2D30",
  one_bg3 = "#333333",
  grey = "#3E3E42",
  grey_fg = "#6A6A6A",
  grey_fg2 = "#858585",
  light_grey = "#A6A6A6",
  line = "#2B2B2B",
  red = "#F44747",
  baby_pink = "#F48771",
  pink = "#C586C0",
  green = "#6A9955",
  green1 = "#4EC9B0",
  vibrant_green = "#B5CEA8",
  blue = "#569CD6",
  nord_blue = "#4FC1FF",
  yellow = "#DCDCAA",
  sun = "#D7BA7D",
  purple = "#C586C0",
  dark_purple = "#AE81FF",
  teal = "#4EC9B0",
  orange = "#CE9178",
  cyan = "#9CDCFE",
  statusline_bg = "#181818",
  lightbg = "#252526",
  pmenu_bg = "#264F78",
  folder_bg = "#D7BA7D",
})

M.base_16 = vim.tbl_deep_extend("force", M.base_16, {
  base00 = "#181818",
  base01 = "#1E1E1E",
  base02 = "#252526",
  base03 = "#3E3E42",
  base04 = "#858585",
  base05 = "#D4D4D4",
  base06 = "#E9E9E9",
  base07 = "#FFFFFF",
  base08 = "#F44747",
  base09 = "#CE9178",
  base0A = "#DCDCAA",
  base0B = "#6A9955",
  base0C = "#9CDCFE",
  base0D = "#569CD6",
  base0E = "#C586C0",
  base0F = "#D7BA7D",
})

M.polish_hl = vim.tbl_deep_extend("force", M.polish_hl or {}, {
  defaults = {
    Normal = { bg = M.base_30.black, fg = M.base_30.white },
    NormalFloat = { bg = M.base_30.black2 },
    CursorLine = { bg = M.base_30.one_bg },
    CursorLineNr = { fg = M.base_30.yellow, bold = true },
    LineNr = { fg = M.base_30.grey_fg },
    Comment = { fg = M.base_30.green, italic = true },
    Visual = { bg = "#264F78" },
    Search = { bg = "#613315", fg = M.base_30.white },
    IncSearch = { bg = M.base_30.blue, fg = M.base_30.black },
    Pmenu = { bg = M.base_30.one_bg2, fg = M.base_30.white },
    PmenuSel = { bg = M.base_30.pmenu_bg, fg = M.base_30.white },
    WinSeparator = { fg = M.base_30.line },
  },
  treesitter = {
    ["@comment"] = { fg = M.base_30.green, italic = true },
    ["@keyword"] = { fg = M.base_30.blue },
    ["@keyword.function"] = { fg = M.base_30.purple },
    ["@function"] = { fg = M.base_30.yellow },
    ["@function.call"] = { fg = M.base_30.yellow },
    ["@string"] = { fg = M.base_30.orange },
    ["@number"] = { fg = M.base_30.green1 },
    ["@type"] = { fg = M.base_30.teal },
    ["@variable"] = { fg = M.base_30.cyan },
    ["@property"] = { fg = M.base_30.cyan },
  },
})

M.type = "dark"

return require("base46").override_theme(M, "cursor_dark")
