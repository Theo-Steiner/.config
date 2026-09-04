return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	-- get correct commentstring before commenting (configured line 18-20)
	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	lazy = false,
	build = ":TSUpdate",
	config = function()
		vim.g.skip_ts_context_commentstring_module = true
		vim.cmd([[autocmd BufRead,BufEnter *.astro set filetype=astro]])

		local parsers = {
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
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"query",
			"regex",
			"rust",
			"svelte",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"vue",
			"yaml",
		}
		local filetypes = vim.list_extend(vim.deepcopy(parsers), { "jsonc" })

		vim.treesitter.language.register("json", "jsonc")

		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
