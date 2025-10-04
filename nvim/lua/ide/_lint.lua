local lint_with_root_dir = function()
	local lint = require("lint")
	local get_clients = vim.lsp.get_clients
	local client = get_clients({ bufnr = 0 })[1] or {}
	lint.try_lint(nil, { cwd = client.root_dir, ignore_errors = true })
end

return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		-- use 'eslint_d' instead of 'eslint' to avoid node startup cost
		local eslint_d = 'eslint_d'
		-- attach linters for filetypes
		lint.linters_by_ft = {
			javascript = { eslint_d },
			javascriptreact = { eslint_d },
			typescript = { eslint_d },
			typescriptreact = { eslint_d },
			vue = { eslint_d },
			svelte = { eslint_d },
			go = { "golangcilint" }
		}
		-- setup lua autocommand to lint when first opening, after inserting and when writing the buffer.
		vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost", "BufEnter", "LspAttach" }, {
			callback = function()
				lint_with_root_dir()
			end,
		})
		vim.api.nvim_create_user_command("Lint", function()
			lint_with_root_dir()
		end, {})
	end,
}
