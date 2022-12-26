local lsp_zero = require("lsp-zero")

lsp_zero.preset("recommended")
lsp_zero.set_preferences({
	set_lsp_keymaps = false,
	sign_icons = {
		error = "",
		warn = "",
		hint = "",
		info = "",
	},
})

-- a list of default servers with a boolean value indicating whether they have their formatting disabled to defer formatting to null_ls
local default_servers = {
	'html',
	'cssls',
	'tsserver',
	'svelte',
	'sumneko_lua',
	'volar',
	'jsonls',
	'emmet_ls',
}
lsp_zero.ensure_installed(default_servers)

for _, servername in pairs(default_servers) do
	local additional_config
	local modified_filetypes
	-- config for specific LSPs (e.g. setup lua workspace/globals)
	if servername == "sumneko_lua" then
		local runtime_path = vim.split(package.path, ";")
		table.insert(runtime_path, "lua/?.lua")
		table.insert(runtime_path, "lua/?/init.lua")
		additional_config = {
			Lua = {
				format = {
					enable = true,
					defaultConfig = { indent_style = "tab", indent_size = 4 },
				},
				diagnostics = {
					globals = { "vim", "use", "AUTO_FORMAT" },
				},
				runtime = { version = "LuaJIT", path = runtime_path },
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
					},
				},
			},
		}
	end
	if servername == "emmet_ls" then
		modified_filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'vue', 'css', 'sass', 'scss', 'less' }
	end
	if servername == "volar" then
		modified_filetypes = { 'vue', 'typescript', 'javascript' }
	end
	lsp_zero.configure(
		servername,
		{
			on_attach = AUTO_FORMAT,
			filetypes = modified_filetypes,
			settings = additional_config
		}
	)
end
-- icons to display alongside completion items
local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
lsp_zero.setup_nvim_cmp({
	view = { entries = "native" },
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = kind_icons[vim_item.kind] .. " " .. vim_item.kind .. " "
			return vim_item
		end,
	},
	completion = {
		get_trigger_characters = function(trigger_characters)
			local new_trigger_characters = {}
			for _, char in ipairs(trigger_characters) do
				if char ~= '>' then
					table.insert(new_trigger_characters, char)
				end
			end
			return new_trigger_characters
		end
	}
})

-- setup the lsp with the above config
lsp_zero.setup()
