-- ****************************************
-- ************** DIAGNOSTICS *************
-- ****************************************
local M = {}

M.setup = function()
	-- icons for diagnostic errors
	vim.fn.sign_define(
		"DiagnosticSignError",
		{ text = " ", texthl = "DiagnosticSignError" }
	)
	vim.fn.sign_define(
		"DiagnosticSignWarn",
		{ text = " ", texthl = "DiagnosticSignWarn" }
	)
	vim.fn.sign_define(
		"DiagnosticSignInfo",
		{ text = " ", texthl = "DiagnosticSignInfo" }
	)
	vim.fn.sign_define(
		"DiagnosticSignHint",
		{ text = "󰌵", texthl = "DiagnosticSignHint" }
	)

	-- make diagnostics show in float
	vim.diagnostic.config({
		virtual_text = false,
		float = {
			header = '',
			source = 'if_many',
			border = nil,
		},
	})
	vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
end

return M
