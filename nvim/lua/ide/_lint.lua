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
		vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost", "BufEnter" }, {
			callback = function()
				require("lint").try_lint(nil, { ignore_errors = true })
			end,
		})
		vim.api.nvim_create_user_command("Lint", function()
			require("lint").try_lint()
		end, {})
	end,
}
