-- ****************************************
-- *********** Bootstrap Lazy *************
-- ****************************************
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- ****************************************
-- *********** Lazy Utilities *************
-- ****************************************

M = {}

local modify = function(plugins, config)
	config = config or {}
	for i, plugin in ipairs(plugins) do
		if type(plugin) == "string" then
			plugins[i] = {
				-- if the plugin name contains "nvim" enable auto config
				config = plugin:match("nvim") and true or nil,
				plugin
			}
		end
		-- insert wanted properties into table
		for key, value in pairs(config) do
			plugins[i][key] = value
		end
	end
	return plugins
end

M.onBufferLoad = function(plugins)
	return modify(
		plugins,
		{ lazy = true,
			event = { "BufReadPre", "BufNewFile" },
		}
	)
end

M.onInsertEnter = function(plugins)
	return modify(
		plugins,
		{ lazy = true, event = "InsertEnter" }
	)
end

M.onIdle = function(plugins)
	return modify(
		plugins,
		{ lazy = true, event = "VeryLazy" }
	)
end

M.eagerly = function(plugins)
	return modify(
		plugins
	)
end

M.lazily = function(plugins)
	return modify(
		plugins,
		{ lazy = true }
	)
end

return M
