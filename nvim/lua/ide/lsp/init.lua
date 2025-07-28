return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"folke/neoconf.nvim",
		"folke/lazydev.nvim",
	},
	config = function()
		require("neoconf").setup()
		require("lazydev").setup()
		require("mason").setup()

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(_)
				vim.keymap.set("n", "K", vim.lsp.buf.hover)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
				vim.keymap.set("n", "s", vim.lsp.buf.rename)
				vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
			end
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"html",
				"cssls",
				"svelte",
				"lua_ls",
				"vue_ls",
				"gopls",
				"jsonls",
				"emmet_ls",
				-- instead of using `ts_ls` we use `vtsls` that provides a more vscode like wrapper for the typescript ls
				-- it is also required for `vue_ls` to work properly (see: https://github.com/vuejs/language-tools/wiki/Neovim)
				"vtsls",
				-- disabled by default (special case in is_disabled)
				"denols",
			},
			automatic_enable = {
				exclude = {
					"denols"
				}
			}
		})

		-- setup diagnostics
		require("ide.lsp.diagnostics").setup()
	end,
}
