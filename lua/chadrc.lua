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
		["@tag.attribute"] = { fg = "#87C3FF" },
		["@attribute"] = { fg = "#87C3FF" },
		["@lsp.type.property"] = { fg = "#87C3FF" },
		["@lsp.typemod.property"] = { fg = "#87C3FF" },
		["@lsp.typemod.property.declaration"] = { fg = "#87C3FF" },
		TelescopePromptTitle = { fg = "#E394DC", bg = "NONE", bold = true },
		TelescopeResultsTitle = { fg = "#87C3FF", bg = "NONE", bold = true },
		TelescopePreviewTitle = { fg = "#A8CC7C", bg = "NONE", bold = true },
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

	local separators = utils.separators.round
	local modes = utils.modes
	local mode = modes[vim.api.nvim_get_mode().mode] or modes.n
	local mode_name = mode[2]

	return "%#St_" .. mode_name .. "ModeSep#" .. separators.left
		.. "%#St_" .. mode_name .. "Mode# " .. mode[1]
		.. "%#St_" .. mode_name .. "ModeSep#" .. separators.right
end

local function statusline_segment(text, group, separator_group)
	local separators = require("nvchad.stl.utils").separators.round
	return "%#" .. separator_group .. "#" .. separators.left
		.. "%#" .. group .. "# " .. text .. " "
		.. "%#" .. separator_group .. "#" .. separators.right
end

local function clean_file()
	local utils = require "nvchad.stl.utils"
	local path = vim.api.nvim_buf_get_name(utils.stbufnr())
	local name = path == "" and "Empty" or (path:match "([^/\\]+)[/\\]*$" or path)
	return statusline_segment(name, "St_file", "St_file_sep")
end

local function clean_git()
	local utils = require "nvchad.stl.utils"
	local bufnr = utils.stbufnr()
	local status = vim.b[bufnr].gitsigns_status_dict

	if not status or not status.head or status.head == "" then
		return ""
	end

	local parts = { status.head }
	if status.added and status.added > 0 then
		table.insert(parts, "+" .. status.added)
	end
	if status.changed and status.changed > 0 then
		table.insert(parts, "~" .. status.changed)
	end
	if status.removed and status.removed > 0 then
		table.insert(parts, "-" .. status.removed)
	end

	return "%#St_gitIcons#  " .. table.concat(parts, " ") .. " "
end

local function clean_diagnostics()
	local utils = require "nvchad.stl.utils"
	local bufnr = utils.stbufnr()
	local severity = vim.diagnostic.severity
	local groups = {
		{ "E", "St_lspError", severity.ERROR },
		{ "W", "St_lspWarning", severity.WARN },
		{ "H", "St_lspHints", severity.HINT },
		{ "I", "St_lspInfo", severity.INFO },
	}
	local result = {}

	for _, item in ipairs(groups) do
		local count = #vim.diagnostic.get(bufnr, { severity = item[3] })
		if count > 0 then
			table.insert(result, "%#" .. item[2] .. "#" .. item[1] .. " " .. count)
		end
	end

	return #result > 0 and (" " .. table.concat(result, "  ") .. " ") or ""
end

local function clean_lsp()
	local utils = require "nvchad.stl.utils"
	local bufnr = utils.stbufnr()

	for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
		return "%#St_Lsp#  LSP ~ " .. client.name .. " "
	end

	return ""
end

local function clean_cwd()
	if vim.o.columns <= 85 then
		return ""
	end

	local cwd = vim.uv.cwd() or ""
	local name = cwd:match "([^/\\]+)[/\\]*$" or cwd
	return statusline_segment(name, "St_cwd_text", "St_cwd_sep")
end

local function clean_cursor()
	return statusline_segment("%l/%v", "St_pos_text", "St_pos_sep")
end

M.ui = {
	statusline = {
		separator_style = "round",
		modules = {
			mode = clean_mode,
			file = clean_file,
			git = clean_git,
			lsp_msg = "",
			diagnostics = clean_diagnostics,
			lsp = clean_lsp,
			cwd = clean_cwd,
			cursor = clean_cursor,
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
