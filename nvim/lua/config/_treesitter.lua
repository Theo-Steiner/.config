vim.cmd([[autocmd BufRead,BufEnter *.astro set filetype=astro]])

require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	ignore_install = { "phpdoc" },

	sync_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		-- this indentation currently over indents after closing a tag
		enable = false,
	},
	context_commentstring = {
		enable = true
	}
})
