local lint_with_root_dir = function()
	local lint = require("lint")
	local get_clients = vim.lsp.get_clients
	local client = get_clients({ bufnr = 0 })[1] or {}
	lint.try_lint(nil, { cwd = client.root_dir })
end

return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		-- attach linters for filetypes
		lint.linters_by_ft = {
			css = { "stylelint" },
			javascript = { "eslint" },
			javascriptreact = { "eslint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
			vue = { "eslint" },
			svelte = { "eslint" },
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
