-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "gruvbox_light",
	transparency = true,

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

local function rounded_buffers()
	local api = vim.api
	local style_buf = require("nvchad.tabufline.utils").style_buf
	local buffers = {}

	vim.t.bufs = vim.tbl_filter(api.nvim_buf_is_valid, vim.t.bufs or {})

	for i, nr in ipairs(vim.t.bufs) do
		local active = api.nvim_get_current_buf() == nr
		local group = active and "TbBufOn" or "TbBufOff"
		local hl = api.nvim_get_hl(0, { name = group, link = false })
		local separator = "TbRound" .. (active and "On" or "Off")

		api.nvim_set_hl(0, separator, {
			fg = hl.bg or hl.fg,
			bg = "NONE",
		})

		table.insert(buffers, "%#" .. separator .. "#" .. style_buf(nr, i, 21) .. "%#" .. separator .. "#")
	end

	return table.concat(buffers) .. "%="
end

M.ui = {
	statusline = {
		separator_style = "round",
	},
	tabufline = {
		modules = {
			buffers = rounded_buffers,
		},
	},
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
