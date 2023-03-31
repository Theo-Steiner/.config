-- Function using buffernames to see if "Trouble" is open
local check_trouble_state = function()
	for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
		if string.match(vim.api.nvim_buf_get_name(buffer), "Trouble") then
			return true
		end
	end
	return false
end

-- Step through diagnostic messages or trouble entries if there
local next_diagnostic_or_trouble = function(forwards)
	local is_trouble_open = check_trouble_state()
	if is_trouble_open then
		if forwards then
			require("trouble").next({ skip_groups = true, jump = true })
		else
			require("trouble").previous({ skip_groups = true, jump = true })
		end
		return
	end
	if forwards then
		vim.diagnostic.goto_next()
	else
		vim.diagnostic.goto_prev()
	end
end

-- Populate trouble with document diagnostics
local close_or_open_with_diagnostics = function()
	local is_trouble_open = check_trouble_state()
	if is_trouble_open then
		require("trouble").close()
	else
		vim.cmd([[TroubleToggle workspace_diagnostics]])
	end
end

return {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "gt", "<cmd>TroubleToggle lsp_type_definitions<cr>" },
		{ "gr", "<cmd>TroubleToggle lsp_references<cr>" },
		{ "gd", "<cmd>TroubleToggle lsp_definitions<cr>" },
		{
			"<C-p>",
			function()
				next_diagnostic_or_trouble(false)
			end
		},
		{
			"<C-n>",
			function()
				next_diagnostic_or_trouble(true)
			end
		},
		{
			"<C-t>", close_or_open_with_diagnostics, { noremap = true }
		},
	},
	config = function()
		require("trouble").setup({
			action_keys = { open_tab = "<c-q>" },
		})
	end,
}
