-- ****************************************
-- ************** KEYBINDINGS *************
-- ****************************************

-- source vim config with <leader> enter
Map("n", "<leader><CR>", "<cmd>lua Reload()<cr>")

-- use <leader> f to open fuzzy finder preview to find file in project
Map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
-- use <leader> f to open fuzzy finder preview to live-grep in project
Map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")

-- <leader> c toggles the current line or current selection to be a comment
Map("", "<leader>c", function()
	require('ts_context_commentstring.internal').update_commentstring()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":Commentary<CR>", true, false, true), "", false)
end
)

-- open file tree witvh <leader> p
Map("n", "<leader>pv", ":Neotree reveal toggle<cr>")


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
