-- ****************************************
-- ************** Formatting **************
-- ****************************************

-- add global to track if auto formatting is enabled
vim.g.AutoFormattingEnabled = true

-- filter what servers are used to format
local format = function(bufnr)
	bufnr = bufnr or 0
	vim.lsp.buf.format({
		filter = function(client)
			-- servers that should be used for formatting go here
			-- only format with prettier (null-ls) or lua_ls
			return client.name == "null-ls" or client.name == "lua_ls"
		end,
		bufnr = bufnr,
	})
	-- keep gitsigns in sync after formatting
	require("gitsigns").refresh()
end

-- add commands for to format and toggle auto formatting
vim.api.nvim_create_user_command("Formatting",
	function() vim.g.AutoFormattingEnabled = not vim.g.AutoFormattingEnabled end, {})
vim.api.nvim_create_user_command("Format", function() format() end, {})

-- augroup for formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- attach this handler as on_attach callback to enable lsp autoformatting
AUTO_FORMAT = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				if vim.g.AutoFormattingEnabled then
					format(bufnr)
				end
			end,
		})
	end
end
