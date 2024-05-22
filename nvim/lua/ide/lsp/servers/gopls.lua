return {
	settings = {
		gopls = {
			completeUnimported = true,
			analyses = {
				unusedparams = true
			}
		},
	},
	filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' }
}
