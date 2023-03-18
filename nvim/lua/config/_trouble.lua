require("trouble").setup({
	action_keys = { open_tab = "<c-q>" },
})

-- Function using buffernames to see if "Trouble" is open
local check_trouble_state = function()
	for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
		if string.match(vim.api.nvim_buf_get_name(buffer), "Trouble") then
			return true
		end
	end
	return false
end

local trouble = require("trouble")
-- Step through diagnostic messages or trouble entries if there
local next_diagnostic_or_trouble = function(forwards)
	local is_trouble_open = check_trouble_state()
	if is_trouble_open then
		if forwards then
			trouble.next({ skip_groups = true, jump = true })
		else
			trouble.previous({ skip_groups = true, jump = true })
		end
		return
	end
	if forwards then
		vim.diagnostic.goto_next()
	else
		vim.diagnostic.goto_prev()
	end
end
Map("n", "<C-p>", function()
	next_diagnostic_or_trouble(false)
end)
Map("n", "<C-n>", function()
	next_diagnostic_or_trouble(true)
end)

-- Populate trouble with document diagnostics
local close_or_open_with_diagnostics = function()
	local is_trouble_open = check_trouble_state()
	if is_trouble_open then
		trouble.close()
	else
		vim.cmd([[TroubleToggle workspace_diagnostics]])
	end
end
Map("n", "<C-t>", close_or_open_with_diagnostics, { noremap = true })
