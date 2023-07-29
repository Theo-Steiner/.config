return {
	"nvim-treesitter/nvim-treesitter",
	-- get correct commentstring before commenting (configured line 18-20)
	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	build = ":TSUpdate",
	config = function()
		vim.cmd([[autocmd BufRead,BufEnter *.astro set filetype=astro]])
		require("nvim-treesitter.configs").setup({
			modules = {},
			auto_install = true,
			ensure_installed = "all",
			-- disable because they throw errors I don't understand
			ignore_install = { "phpdoc", "markdown_inline", "cpp" },
			sync_install = false,
			highlight = {
				enable = true,
				disable = function(_, bufnr) return require("utils").is_huge_file(bufnr) end,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				-- this indentation currently over indents after closing a tag
				enable = false,
			},
			context_commentstring = {
				enable = true
			},
		})
	end,
}
