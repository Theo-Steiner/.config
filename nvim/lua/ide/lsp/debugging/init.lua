return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio"
	},
	keys = {
		-- normal mode is default
		{ "<leader>d", function() require 'dap'.toggle_breakpoint() end },
		{ "<leader>c", function() require 'dap'.continue() end },
		{ "<C-'>",     function() require 'dap'.step_over() end },
		{ "<C-;>",     function() require 'dap'.step_into() end },
		{ "<C-:>",     function() require 'dap'.step_out() end },
	},
	config = function()
		require("dapui").setup()
		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open({ reset = true })
		end
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	end
}
