-- clear background highlights for transparency
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local hl_groups = {
			"Normal",
			"NormalFloat",
			"NormalNC",
			"SignColumn",
			"NvimTreeNormal",
			"NvimTreeNormalNC",
			"LineNr",
			"Folded",
			"NonText",
		}
		for _, group in ipairs(hl_groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
		end
	end,
})

-- set colorscheme to bark
pcall(vim.cmd.colorscheme, "bark")

-- if you want to get rid of toggling and just set one scheme, you can set here
-- local colorscheme = "catppuccin"
-- vim.cmd('silent! colorscheme catppuccin')
