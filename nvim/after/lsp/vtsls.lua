local svelte_plugin = {
	languages = { "vue" },
	name = "typescript-svelte-plugin",
	location = vim.fn.expand("$MASON/packages/svelte-language-server/node_modules/svelte-language-server"),
	configNamespace = 'typescript',
}
local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server"),
	languages = { 'svelte' },
	configNamespace = 'typescript',
}

return {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					svelte_plugin,
					vue_plugin
				},
			},
		},
	},
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}
