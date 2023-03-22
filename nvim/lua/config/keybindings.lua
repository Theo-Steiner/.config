-- ****************************************
-- ************** KEYBINDINGS *************
-- ****************************************

-- source vim config with <leader> enter
Map("n", "<leader><CR>", "<cmd>lua Reload()<cr>")

-- delete highlights on escape
Map("n", "<ESC>", ":noh<CR>", { silent = true })
