return {
	"leoluz/nvim-dap-go",
	ft = "go",
	dependencies = "mfussenegger/nvim-dap",
	config = function()
		require('dap-go').setup(
			{
				dap_configurations = {
					{
						type = "go",
						name = "Debug main.go",
						request = "launch",
						program = "${workspaceFolder}/main.go"
					},
				}
			}
		)
	end
}
