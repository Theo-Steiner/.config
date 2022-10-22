require("harpoon").setup()

-- ****************************************
-- ************** Keybindings *************
-- ****************************************

Map("n", "<C-H>", function() require("harpoon.ui").nav_file(1) end)
Map("n", "<C-J>", function() require("harpoon.ui").nav_file(2) end)
Map("n", "<C-K>", function() require("harpoon.ui").nav_file(3) end)
Map("n", "<C-L>", function() require("harpoon.ui").nav_file(4) end)

Map("n", "<leader>a", function() print("add") require("harpoon.mark").add_file() end)
Map("n", "<leader>h", function() require("harpoon.ui").toggle_quick_menu() end)
Map("n", "<C-A>", function() require("harpoon.ui").toggle_quick_menu() end)
