-- Set globals used throughout the config files
Set = vim.opt

vim.g.mapleader = " "
Map = function(mode, binding, cmd, options)
	vim.keymap.set(mode, binding, cmd, options)
end

-- helper function to reload lua modules
Reload = function()
	for name, _ in pairs(package.loaded) do
		if name:match("^config") then
			package.loaded[name] = nil
		end
	end
	dofile(vim.env.MYVIMRC)
end

-- load modules with configuration
require("config.basics")
require("config.keybindings")
if vim.g.vscode then
	-- don't load anything for vs code extension
else
	require("config.formatting")
	require("config.packages")
	require("config.appearance")
end

-- TODO Move to diagnostics
vim.fn.sign_define(
	'DiagnosticSignError',
	{ text = '', texthl = 'DiagnosticSignError' }
)
vim.fn.sign_define(
	'DiagnosticSignWarn',
	{ text = '', texthl = 'DiagnosticSignWarn' }
)
vim.fn.sign_define(
	'DiagnosticSignHint',
	{ text = '', texthl = 'DiagnosticSignHint' }
)
vim.fn.sign_define(
	'DiagnosticSignInfo',
	{ text = '', texthl = 'DiagnosticSignInfo' }
)
vim.diagnostic.config({
	virtual_text = false,
	float = {
		header = "",
		source = 'if_many',
		border = 'rounded',
	},
})
Map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
