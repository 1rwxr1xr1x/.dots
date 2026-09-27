local lualine = require('lualine')

-- adapted diagnostic component from statusline.lua
local function lambda_diagnostics()
	local mode = vim.api.nvim_get_mode().mode
	if mode == 'c' or mode == 't' then
		return 'λ'
	end

	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

	local parts = {}
	if errors > 0 then
		table.insert(parts, '✘ ' .. errors)
	end
	if warnings > 0 then
		table.insert(parts, '▲ ' .. warnings)
	end

	if #parts == 0 then
		return 'λ'
	end
	return table.concat(parts, ' ')
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = '|',
		section_separators = '',
		globalstatus = true,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = {
			{
				lambda_diagnostics,
				color = function()
					local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
					local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
					if errors > 0 then
						return 'DiagnosticError'
					elseif warnings > 0 then
						return 'DiagnosticWarn'
					end
					return nil
				end,
			},
		},
		lualine_c = {
			{
				'filename',
				file_status = true, -- shows readonly/modified flags (%r, %m)
				path = 0, -- tail filename (%t)
			},
		},
		lualine_x = { 'filetype' },
		lualine_y = {},
		lualine_z = {
			{
				'location',
				fmt = function()
					return string.format('%3d:%-2d', vim.fn.line('.'), vim.fn.col('.'))
				end,
			},
		},
	},
})
