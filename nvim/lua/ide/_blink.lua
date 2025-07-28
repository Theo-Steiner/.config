return {
	'saghen/blink.cmp',
	version = '1.*',
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = 'none',
			['<S-Tab>'] = { 'select_prev', 'fallback' },
			['<Tab>'] = { 'select_next', 'fallback' },
			['<CR>'] = { 'accept', 'fallback' },
			['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
			['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
			['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
			['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
			['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
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
