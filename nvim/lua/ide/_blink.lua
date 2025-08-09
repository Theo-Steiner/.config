return {
	'saghen/blink.cmp',
	version = '1.*',
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = 'default',
			['<C-f>'] = false
		},
		appearance = {
			nerd_font_variant = 'mono'
		},
		completion = {
			documentation = { auto_show = true },
			accept = {
				auto_brackets = {
					enabled = false,
				}
			}
		},
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}
