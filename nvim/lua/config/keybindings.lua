-- ****************************************
-- ************** KEYBINDINGS *************
-- ****************************************

-- source vim config with <leader> enter
Map("n", "<leader><CR>", "<cmd>lua Reload()<cr>")

-- use <leader> ff to open fuzzy finder preview to find file in project
Map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
-- use <leader> fg to open fuzzy finder preview to live-grep in project
Map("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
-- use <leader> fc to search for merge conflicts
Map("n", "<leader>fc", "<cmd>Telescope grep_string search=<<<<<<<<cr>")

-- <leader> c toggles the current line or current selection to be a comment
Map("", "<leader>c", function()
	require('ts_context_commentstring.internal').update_commentstring()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":Commentary<CR>", true, false, true), "", false)
end
)

Map("n", "<ESC>", ":noh<CR>")

-- open file tree witvh <leader> p
Map("n", "<leader>pv", ":Neotree reveal toggle<cr>")
