local svelte_plugin = {
	name = "@vue/typescript-plugin",
	location = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
	languages = { "vue" },
	configNamespace = 'typescript',
}
local vue_plugin = {
	name = "typescript-svelte-plugin",
	location = vim.fn.expand("$MASON/packages/svelte-language-server/node_modules/typescript-svelte-plugin"),
	languages = { "svelte" },
	configNamespace = 'typescript',
}

return {
	init_options = {
		plugins = {
			svelte_plugin,
			vue_plugin
		},
	},
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue' },
}
