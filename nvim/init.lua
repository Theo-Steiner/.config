-- don't load anything if nvim is started for v****e extensions
-- or when opening a huge file
if vim.g.vscode then
	return
end

-- load modules with configuration
require("basics")
require("keybindings")
require("appearance")
require("packages")
