return {
	"folke/sidekick.nvim",
	opts = {
		copilot = {
			-- track status for lualine integration
			status = {
				enabled = true,
			},
		},
	},
	keys = {
		{
			"<tab>",
			function()
				if not require("sidekick").nes_jump_or_apply() then
					return "<Tab>" -- fallback to normal tab
				end
			end,
			expr = true,
			desc = "Goto/Apply Next Edit Suggestion",
		},
		{
			"<leader>aa",
			function() require("sidekick.cli").toggle('opencode') end,
			desc = "Sidekick Toggle CLI",
		},
		{
			"<leader>ap",
			function() require("sidekick.cli").prompt() end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
		{
			"<c-.>",
			function() require("sidekick.cli").focus() end,
			mode = { "n", "x", "i", "t" },
			desc = "Sidekick Switch Focus",
		}
	},
}
