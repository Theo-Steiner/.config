return {
	"nvim-treesitter/nvim-treesitter",
	-- get correct commentstring before commenting (configured line 18-20)
	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	build = ":TSUpdate",
	config = function()
		vim.g.skip_ts_context_commentstring_module = true
		vim.cmd([[autocmd BufRead,BufEnter *.astro set filetype=astro]])
		require("nvim-treesitter.configs").setup({
			modules = {},
			auto_install = true,
			ensure_installed = {
				"bash",
				"css",
				"diff",
				"dockerfile",
				"gitcommit",
				"gitignore",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"query",
				"regex",
				"svelte",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"yaml",
			},
			sync_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				-- this indentation currently over indents after closing a tag
				enable = false,
			},
		})
	end,
}
