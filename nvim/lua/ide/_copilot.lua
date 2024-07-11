return {
	"github/copilot.vim",
	config = function()
		-- disable tab completion for github copilot
		vim.g.copilot_no_tab_map = true
		vim.g.copilot_assume_mapped = true;
		vim.g.copilot_tab_fallback = "";
		-- set copilot completion keybinding to <C-f>
		vim.keymap.set('i', '<C-f>', 'copilot#Accept("\\<CR>")', {
			expr = true,
			nowait = true,
			replace_keycodes = false,
			silent = true
		})
	end
}
