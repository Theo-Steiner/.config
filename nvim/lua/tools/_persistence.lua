return {
	"folke/persistence.nvim",
	opts = {},
	init = function()
		local restart_count = tonumber(os.getenv("RESTART_COUNT"))
		if restart_count ~= nil and restart_count > 0 then
			require('persistence').load()
		end
	end
}
