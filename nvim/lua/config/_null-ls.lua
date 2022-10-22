local null_ls = require("null-ls")

local generate_source_with_fallback = function(source_command, source_generator, config, additional_args)
	config = config or {}
	local utils = require("null-ls.utils").make_conditional_utils()
	local project_local_bin = "node_modules/.bin/" .. source_command

	local command = utils.root_has_file(project_local_bin) and project_local_bin or source_command
	config["command"] = command
	-- TODO: once prettier implements a new algorithm for searching for plugins, its extra args no longer have to be passed
	-- This doesn't work in combination with only_local however, so turning of global prettier using :Formatting is necessary for now
	config["extra_args"] = additional_args
	return source_generator(config)
end

-- use local prettier if available, otherwise fall back to global
local prettier = generate_source_with_fallback("prettier", null_ls.builtins.formatting.prettier.with, {
	filetypes = {
		"svelte",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"css",
		"scss",
		"less",
		"html",
		"json",
		"jsonc",
		"yaml",
		"markdown",
		"graphql",
		"handlebars",
	},
	-- TODO: prettier plugin not found with pnpm, unless below line included
	-- upstream issue: prettier/prettier/pull/11248
}, { "--plugin-search-dir=." })

-- use only local eslint
local eslint = null_ls.builtins.diagnostics.eslint.with({
	only_local = "node_modules/.bin",
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" }
})

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black,
		prettier,
		eslint,
		null_ls.builtins.code_actions.gitsigns,
	},
	on_attach = AUTO_FORMAT,
})
