-- ****************************************
-- ************** KEYBINDINGS *************
-- ****************************************

-- restart nvim with <leader> enter
-- How does this work? This basically crashes the current nvim process (exit code 1 instead of 0)
-- if nvim was started with the `.config/bin/nvim_auto_restart` script,
-- a crash exit (code 1) will trigger a restart of nvim, while a normal exit (code 0) breaks the while loop
vim.keymap.set("n", "<leader><CR>", "<cmd>lua os.exit(1)<cr>")

-- delete highlights on escape
vim.keymap.set("n", "<ESC>", ":noh<CR>", { silent = true })
