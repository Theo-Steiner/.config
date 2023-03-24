return {
	"VonHeikemen/lsp-zero.nvim",
	keys = {
		-- LSP keybindings
		{ "K", "<cmd>lua vim.lsp.buf.hover()<cr>" },
		{ "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>" },
		{ "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>" },
		{ "s", "<cmd>lua vim.lsp.buf.rename()<cr>" },
		{ "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>" },
		{ "gl", "<cmd>lua vim.diagnostic.open_float()<cr>" },
		-- see config._trouble
		{ "gt" },
		{ "gr" },
		{ "gd" },
	},
	config = function()
		-- configure lsp-zero, a wrapper around nvim-cmp for n00bs like me
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

		-- a list of default servers
		local default_servers = {
			'html',
			'cssls',
			'tsserver',
			'svelte',
			'lua_ls',
			'volar',
			'jsonls',
			'emmet_ls',
		}
		lsp_zero.ensure_installed(default_servers)

		for _, servername in pairs(default_servers) do
			local additional_config
			local modified_filetypes
			-- config for specific LSPs (e.g. setup lua workspace/globals)
			if servername == "lua_ls" then
				local runtime_path = vim.split(package.path, ";")
				table.insert(runtime_path, "lua/?.lua")
				table.insert(runtime_path, "lua/?/init.lua")
				additional_config = {
					Lua = {
						format = {
							enable = true,
							defaultConfig = { indent_style = "space", indent_size = 2 },
						},
						diagnostics = {
							globals = { "vim", "use", "AUTO_FORMAT", "Set", "Map" },
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
	end,
	dependencies = {
		-- LSP Support
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
		"williamboman/mason.nvim",
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		-- Snippet Engine
		"L3MON4D3/LuaSnip",
	},
}
