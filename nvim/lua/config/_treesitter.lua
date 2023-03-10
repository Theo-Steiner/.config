vim.cmd([[autocmd BufRead,BufEnter *.astro set filetype=astro]])

require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	-- disable because they throw errors I don't understand
	ignore_install = { "phpdoc", "markdown_inline", "cpp" },

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
