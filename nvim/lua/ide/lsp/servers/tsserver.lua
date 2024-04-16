return {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vim.fn.stdpath('data') ..
						'/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin',
				languages = { 'typescript', 'javascript', 'vue' }
			},
			-- TODO: as of today (4/16/2024) @vue/typescript-plugin does not work with:
			-- "typescript-svelte-plugin",
			-- it should however be fixed in this PR: https://github.com/sveltejs/language-tools/pull/2317
		}
	},
	filetypes = {
		"javascript",
		"typescript",
		"vue",
	},
}
