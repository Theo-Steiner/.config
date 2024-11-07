return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	config = function()
		local slow_format_filetypes = {}
		require("conform").setup({
			formatters_by_ft = {
				javascript = { "prettier", lsp_format = "never" },
				typescript = { "prettier", lsp_format = "never" },
				vue = { "prettier", lsp_format = "never" },
				svelte = { "prettier", lsp_format = "never" },
				scss = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				markdown = { "prettier" },
				json = { "prettier", lsp_format = "never" },
				-- tsconfig.json files are automatically opened as 'jsonc' files (see lsp/servers/jsonls.lua)
				jsonc = { "prettier", lsp_format = "never" },
			},
			format_on_save = function(bufnr)
				-- Disable sync formatting when autoformatting is disabled, or sync formatting for the filetype too slow
				if vim.g.disable_autoformat or slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end

				local function on_format(err)
					if err and err:match("timeout$") then
						slow_format_filetypes[vim.bo[bufnr].filetype] = true
					end
				end

				return { timeout_ms = 200, lsp_format = "fallback" }, on_format
			end,
			format_after_save = function(bufnr)
				-- only do async formatting when autoformatting is enabled, and sync formatting too slow
				if vim.g.disable_autoformat or not slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				return { lsp_format = "fallback" }
			end,
		})
		vim.g.disable_autoformat = false
		-- add commands for to format and toggle auto formatting
		vim.api.nvim_create_user_command("Formatting", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
		end, {})
		vim.api.nvim_create_user_command("Fmt", function(args)
			require("conform").format({ async = true, lsp_format = "fallback", bufnr = args.bufnr })
		end, {})
	end,
}
