return {
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		-- use only local prettier if available
		local prettier = null_ls.builtins.formatting.prettier.with({
			only_local = 'node_modules/.bin',
			extra_filetypes = {
				"svelte",
			}
		})

		-- use only local eslint
		local eslint = null_ls.builtins.diagnostics.eslint.with({
			only_local = 'node_modules/.bin',
			extra_filetypes = {
				"svelte",
			}
		})

		-- use only local stylelint
		local stylelint = null_ls.builtins.diagnostics.stylelint.with({
			only_local = 'node_modules/.bin',
		})

		null_ls.setup({
			root_dir = require("null-ls.utils").root_pattern(".git", "package.json"),
			sources = {
				null_ls.builtins.formatting.black,
				stylelint,
				prettier,
				eslint,
				null_ls.builtins.code_actions.gitsigns,
			},
			on_attach = require("ide.formatting").auto_format,
		})
	end
}
