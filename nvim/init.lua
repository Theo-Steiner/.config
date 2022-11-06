-- Set globals used throughout the config files
Set = vim.opt

vim.g.mapleader = " "
Map = function(...)
	vim.keymap.set(...)
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
