-- Set globals used throughout the config files
Set = vim.opt

vim.g.mapleader = " "
Map = function(mode, binding, cmd, options)
	if options == nil then
		options = {}
	end
	if options.silent == nil then
		options.silent = true
	end
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
	require("config.packages")
	require("config.lsp")
	require("config.appearance")
end
