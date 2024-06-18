-- Populate trouble with document diagnostics
local close_or_open_with_diagnostics = function()
	local trouble = require("trouble")
	local is_trouble_open = trouble.is_open()
	if is_trouble_open then
		trouble.close()
	else
		trouble.open('diagnostics')
	end
end

local preview_next_item = function ()
	local trouble = require("trouble")
	if trouble.is_open() then
		---@diagnostic disable: missing-parameter
		trouble.focus()
		trouble.next()
		---@diagnostic enable: missing-parameter
	end
end

local preview_previous_item = function ()
	local trouble = require("trouble")
	if trouble.is_open() then
		---@diagnostic disable: missing-parameter
		trouble.focus()
		trouble.prev()
		---@diagnostic enable: missing-parameter
	end
end

return {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "gr", "<cmd>Trouble lsp_references toggle<cr>" },
		{ "gd", "<cmd>Trouble lsp_definitions toggle<cr>" },
		{ "gt", "<cmd>Trouble lsp_type_definitions toggle<cr>" },
		{
			"<C-k>",
			preview_previous_item
		},
		{
			"<C-j>",
			preview_next_item
		},
		{
			"<C-t>", close_or_open_with_diagnostics, { noremap = true }
		},
	},
	config = function()
		require("trouble").setup({auto_jump = true})
	end,
}
