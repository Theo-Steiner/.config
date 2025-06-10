return {
	init_options = {
		vue = {
			hybridMode = true
		}
	},
	filetypes = { 'vue', 'md' },
	on_init = function(client)
		client.handlers['tsserver/request'] = function(_, result, context)
			local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })
			if #clients == 0 then
				vim.notify('Could not find `ts_ls` lsp client, vue_lsp would not work with it.', vim.log.levels.ERROR)
				return
			end
			local ts_client = clients[1]

			local param = unpack(result)
			local id, command, payload = unpack(param)
			ts_client:exec_cmd({
				command = 'typescript.tsserverRequest',
				arguments = {
					command,
					payload,
				},
			}, { bufnr = context.bufnr }, function(_, r)
				local response_data = { { id, r.body } }
				---@diagnostic disable-next-line: param-type-mismatch
				client:notify('tsserver/response', response_data)
			end)
		end
	end,
}
