return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		-- normal mode is default
		{ "<C-H>", function() require("harpoon.ui").nav_file(1) end },
		{ "<C-J>", function() require("harpoon.ui").nav_file(2) end },
		{ "<C-K>", function() require("harpoon.ui").nav_file(3) end },
		{ "<C-L>", function() require("harpoon.ui").nav_file(4) end },
		{ "<leader>a", function() print("add") require("harpoon.mark").add_file() end, silent = true },
		{ "<leader>h", function() require("harpoon.ui").toggle_quick_menu() end, silent = true },
		{ "<C-A>", function() require("harpoon.ui").toggle_quick_menu() end, silent = true },
	},
	config = function()
		require("harpoon").setup()
	end,
}
