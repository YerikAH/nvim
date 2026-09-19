require "nvchad.autocmds"

-- jsonc usa el parser JSON porque Tree-sitter no distribuye un parser separado.
vim.treesitter.language.register("json", "jsonc")

-- Guarda archivos modificados después de una pausa corta. El guardado dispara
-- Conform, por lo que Prettier/Ruff/Stylua se ejecutan antes de escribir.
local autosave_group = vim.api.nvim_create_augroup("NvChadAutoSave", { clear = true })
local autosave_generation = {}

local function can_autosave(bufnr)
  return vim.api.nvim_buf_is_valid(bufnr)
    and vim.api.nvim_buf_get_name(bufnr) ~= ""
    and vim.bo[bufnr].buftype == ""
    and vim.bo[bufnr].modifiable
    and not vim.bo[bufnr].readonly
    and vim.bo[bufnr].modified
    and vim.bo[bufnr].filetype ~= "gitcommit"
    and vim.bo[bufnr].filetype ~= "gitrebase"
end

local function schedule_autosave(bufnr, delay)
  autosave_generation[bufnr] = (autosave_generation[bufnr] or 0) + 1
  local generation = autosave_generation[bufnr]

  vim.defer_fn(function()
    if autosave_generation[bufnr] ~= generation or not can_autosave(bufnr) then
      return
    end

    -- No reformatea mientras se está escribiendo; InsertLeave hará el guardado.
    if bufnr == vim.api.nvim_get_current_buf() and vim.api.nvim_get_mode().mode:sub(1, 1) == "i" then
      return
    end

    vim.api.nvim_buf_call(bufnr, function()
      local ok, err = pcall(vim.cmd, "silent update")
      if not ok then
        vim.notify("No se pudo autoguardar: " .. tostring(err), vim.log.levels.ERROR)
      end
    end)
  end, delay)
end

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
  group = autosave_group,
  callback = function(args)
    schedule_autosave(args.buf, 700)
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = autosave_group,
  callback = function(args)
    schedule_autosave(args.buf, 50)
  end,
})

vim.api.nvim_create_autocmd("BufWipeout", {
  group = autosave_group,
  callback = function(args)
    autosave_generation[args.buf] = nil
  end,
})
