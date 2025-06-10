-- ****************************************
-- ************** DIAGNOSTICS *************
-- ****************************************
local M = {}

M.setup = function()
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
	vim.keymap.set("n", "<C-p>", function() vim.diagnostic.jump({ count = -1, float = true }) end)
	vim.keymap.set("n", "<C-n>", function() vim.diagnostic.jump({ count = 1, float = true }) end)
end

return M
