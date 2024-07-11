return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	config = function()
		local slow_format_filetypes = {}
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				vue = { "prettier" },
				scss = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				markdown = { "prettier" },
				json = { "prettier" },
				-- tsconfig.json files are automatically opened as 'jsonc' files (see lsp/servers/jsonls.lua)
				jsonc = { "prettier" },
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

				return { timeout_ms = 200, lsp_fallback = "last" }, on_format
			end,
			format_after_save = function(bufnr)
				-- only do async formatting when autoformatting is enabled, and sync formatting too slow
				if vim.g.disable_autoformat or not slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				return { lsp_fallback = "last" }
			end,
		})
		vim.g.disable_autoformat = false
		-- add commands for to format and toggle auto formatting
		vim.api.nvim_create_user_command("Formatting", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
		end, {})
		vim.api.nvim_create_user_command("Fmt", function(args)
			require("conform").format({ async = true, lsp_fallback = "last", bufnr = args.bufnr })
		end, {})
	end,
}
