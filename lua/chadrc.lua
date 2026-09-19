-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "cursor_dark",
	transparency = true,
	hl_override = {
		NvimTreeFileIcon = { fg = "#D4D4D4" },
		NvimTreeFolderIcon = { fg = "#D4D4D4" },
		NvimTreeOpenedFolderIcon = { fg = "#D4D4D4" },
		NvimTreeClosedFolderIcon = { fg = "#D4D4D4" },
	},

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

local function clean_buffers()
	local api = vim.api
	local utils = require("nvchad.tabufline.utils")
	local txt, btn = utils.txt, utils.btn
	local buffers = {}
	local current = api.nvim_get_current_buf

	local function filename(path)
		return path:match "([^/\\]+)[/\\]*$"
	end

	local function style_buf_without_icon(nr, index, width)
		local active = current() == nr
		local hl = active and "BufOn" or "BufOff"
		local name = filename(api.nvim_buf_get_name(nr)) or " No Name "

		for other_index, other_nr in ipairs(vim.t.bufs) do
			if index ~= other_index and filename(api.nvim_buf_get_name(other_nr)) == name then
				name = vim.fn.fnamemodify(api.nvim_buf_get_name(nr), ":h:t") .. "/" .. name
				break
			end
		end

		local maxname = width - 4
		name = string.sub(name, 1, maxname - 2) .. (#name > maxname and ".." or "")
		local pad = math.max(1, math.floor((width - #name - 4) / 2))
		local content = string.rep(" ", pad - 1) .. txt(name, hl) .. string.rep(" ", pad - 1)
		local close = api.nvim_get_option_value("modified", { buf = nr }) and txt("  ", hl .. "Modified")
			or txt(btn(" 󰅖 ", nil, "KillBuf", nr), active and "BufOnClose" or "BufOffClose")

		return txt(btn(content, nil, "GoToBuf", nr) .. close, hl)
	end

	vim.t.bufs = vim.tbl_filter(api.nvim_buf_is_valid, vim.t.bufs or {})

	for i, nr in ipairs(vim.t.bufs) do
		table.insert(buffers, style_buf_without_icon(nr, i, 21))
	end

	return table.concat(buffers) .. "%="
end

local function clean_mode()
	local utils = require "nvchad.stl.utils"
	if not utils.is_activewin() then
		return ""
	end

	local separators = utils.separators.default
	local modes = utils.modes
	local mode = modes[vim.api.nvim_get_mode().mode] or modes.n
	local mode_name = mode[2]

	return "%#St_" .. mode_name .. "Mode# " .. mode[1]
		.. "%#St_" .. mode_name .. "ModeSep#" .. separators.right
		.. "%#ST_EmptySpace#" .. separators.right
end

M.ui = {
	statusline = {
		separator_style = "round",
		modules = {
			mode = clean_mode,
		},
	},
	tabufline = {
		modules = {
			buffers = clean_buffers,
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
