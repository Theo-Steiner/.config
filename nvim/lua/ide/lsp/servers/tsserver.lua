return {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vim.fn.stdpath("data")
					.. "/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
				languages = { "typescript", "javascript", "vue" },
			},
			{
				name = "typescript-svelte-plugin",
				location = vim.fn.stdpath("data")
					.. "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin",
				languages = { "typescript", "javascript", "svelte" },
			},
		},
	},
	filetypes = {
		"javascript",
		"typescript",
		"vue",
	},
}
