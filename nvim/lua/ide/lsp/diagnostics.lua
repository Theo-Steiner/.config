-- ****************************************
-- ************** DIAGNOSTICS *************
-- ****************************************
local M = {}

M.setup = function()
	-- TODO: remove this legacy way of defining diagnostic signs once all plugins support it
	vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
	-- make diagnostics show in float
	vim.diagnostic.config({
		virtual_text = false,
		float = {
			header = "",
			source = "if_many",
			border = nil,
		},
		signs = {
			-- setup diagnostics
			-- icons for diagnostic errors
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.HINT] = "󰌵",
				[vim.diagnostic.severity.INFO] = "",
			},
		},
	})
	vim.keymap.set("n", "gl", vim.diagnostic.open_float)
	vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev)
	vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next)
end

return M
