-- Set globals used throughout the config files
Set = vim.opt

vim.g.mapleader = " "
Map = function(mode, binding, cmd, options)
	vim.keymap.set(mode, binding, cmd, options)
end

-- load modules with configuration
require("config.basics")
require("config.keybindings")
require("config.appearance")

if not vim.g.vscode then
	require("config.formatting")
	require("config.packages")
else
	-- don't load anything for vs code extension
end
