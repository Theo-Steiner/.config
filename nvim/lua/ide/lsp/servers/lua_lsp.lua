local runtime_path = vim.split(package.path, ";", {})
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
	settings = {
		format = {
			enable = true,
			defaultConfig = { indent_style = "space", indent_size = 2 },
		},
		diagnostics = {
			globals = { "vim", "use", "AUTO_FORMAT", "Set" },
		},
		runtime = { version = "LuaJIT", path = runtime_path },
		workspace = {
			library = {
				vim.fn.expand("$VIMRUNTIME/lua"),
			},
		},
	}
}
