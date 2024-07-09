local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		-- Snippet Engine
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif vim.fn["vsnip#available"](1) == 1 then
						feedkey("<Plug>(vsnip-expand-or-jump)", "")
					elseif has_words_before() then
						cmp.complete()
					else
						fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_prev_item()
					elseif vim.fn["vsnip#jumpable"](-1) == 1 then
						feedkey("<Plug>(vsnip-jump-prev)", "")
					end
				end, { "i", "s" }),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				}),
			}),
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
					-- filter out useless snippets of the shape `bla` -> `<bla>${1}</bla>` 
					entry_filter = function(entry)
						-- get the documentation
						local documentation = entry:get_documentation() or {}
						-- useless snippets documentation always have the same shape:
						-- {"```", "trigger_word", "```", "```text", "<trigger_word>${1}</trigger_word>", "```"}
						local trigger_word = documentation[2]
						-- if the item is a useless completion item, it should be of shape "<trigger_word>${1}</trigger_word>"
						local expected_completion_item = ("<%s>${1}</%s>"):format(trigger_word, trigger_word)
						return documentation[5] ~= expected_completion_item
					end,
				},
				{
					name = "vsnip",
				},
				{ name = "buffer" },
				{ name = "path" },
				{ name = "nvim_lua" },
				{ name = "nvim_lsp_signature-help" },
			}),
			formatting = {
				format = require("lspkind").cmp_format({}),
			},
			completion = {
				get_trigger_characters = function(trigger_characters)
					local new_trigger_characters = {}
					for _, char in ipairs(trigger_characters) do
						if char ~= ">" then
							table.insert(new_trigger_characters, char)
						end
					end
					return new_trigger_characters
				end,
			},
		})
	end,
}
