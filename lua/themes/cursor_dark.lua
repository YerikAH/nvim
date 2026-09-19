-- Cursor Dark palette for NvChad/Base46.
-- Ported from Cursor's published workbench and syntax colors.
local M = {}

M.base_30 = {
  white = "#D6D6DD",
  darker_black = "#141414",
  black = "#1A1A1A",
  black2 = "#1F1F1F",
  one_bg = "#202020",
  one_bg2 = "#292929",
  one_bg3 = "#313131",
  grey = "#404040",
  grey_fg = "#505050",
  grey_fg2 = "#6D6D6D",
  light_grey = "#9D9D9D",
  line = "#2B2B2B",
  red = "#BF616A",
  baby_pink = "#C1808A",
  pink = "#E394DC",
  green = "#A8CC7C",
  green1 = "#83D6C5",
  vibrant_green = "#A3BE8C",
  blue = "#87C3FF",
  nord_blue = "#88C0D0",
  yellow = "#F8C762",
  sun = "#EBC88D",
  purple = "#AAA0FA",
  dark_purple = "#8F82D6",
  teal = "#82D2CE",
  orange = "#EFB080",
  cyan = "#82D2CE",
  statusline_bg = "#1A1A1A",
  lightbg = "#292929",
  pmenu_bg = "#404040",
  folder_bg = "#88C0D0",
}

M.base_16 = {
  base00 = "#1A1A1A",
  base01 = "#141414",
  base02 = "#292929",
  base03 = "#404040",
  base04 = "#6D6D6D",
  base05 = "#D6D6DD",
  base06 = "#ECEFF4",
  base07 = "#FFFFFF",
  base08 = "#BF616A",
  base09 = "#EFB080",
  base0A = "#F8C762",
  base0B = "#A8CC7C",
  base0C = "#82D2CE",
  base0D = "#87C3FF",
  base0E = "#AAA0FA",
  base0F = "#E394DC",
}

M.polish_hl = vim.tbl_deep_extend("force", M.polish_hl or {}, {
  defaults = {
    Normal = { bg = M.base_30.black, fg = M.base_30.white },
    NormalFloat = { bg = M.base_30.black2 },
    CursorLine = { bg = "#292929" },
    CursorLineNr = { fg = M.base_30.yellow, bold = true },
    LineNr = { fg = M.base_30.grey_fg },
    Comment = { fg = M.base_30.green, italic = true },
    Visual = { bg = "#404040" },
    Search = { bg = M.base_30.grey, fg = M.base_30.white },
    IncSearch = { bg = "#88C0D0", fg = M.base_30.black },
    Pmenu = { bg = M.base_30.one_bg2, fg = M.base_30.white },
    PmenuSel = { bg = M.base_30.pmenu_bg, fg = M.base_30.white },
    WinSeparator = { fg = M.base_30.line },
  },
  treesitter = {
    ["@comment"] = { fg = M.base_30.green, italic = true },
    ["@keyword"] = { fg = M.base_30.green1 },
    ["@keyword.function"] = { fg = M.base_30.green1 },
    ["@function"] = { fg = M.base_30.orange },
    ["@function.call"] = { fg = M.base_30.orange },
    ["@string"] = { fg = M.base_30.pink },
    ["@number"] = { fg = M.base_30.sun },
    ["@type"] = { fg = M.base_30.blue },
    ["@variable"] = { fg = M.base_30.white },
    ["@property"] = { fg = M.base_30.blue },
  },
})

M.type = "dark"

return require("base46").override_theme(M, "cursor_dark")
