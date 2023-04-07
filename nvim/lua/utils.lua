local M = {}

-- huge is over 100KB
M.is_huge_file = function(bufnr)
	bufnr = bufnr or 0
	local max_filesize = 100 * 1024 -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
	if ok and stats and stats.size > max_filesize then
		return true
	end
end

return M
