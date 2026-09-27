-- native treesitter setup
require("nvim-treesitter").setup({})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("tree-sitter-enable", { clear = true }),
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if not lang then
			return
		end
		pcall(vim.treesitter.start, args.buf)
		if vim.treesitter.query.get(lang, "indents") then
			vim.opt_local.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
		end
	end,
})

-- enable native completion on attach
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
		end
	end,
})

-- racket lsp config
vim.lsp.config("racket-langserver", {
	cmd = { "racket", "-l", "racket-langserver" },
	filetypes = { "racket" },
})
vim.lsp.enable("racket-langserver")

-- revo lsp & treesitter configuration
vim.lsp.config("revo", {
	cmd = { "revo", "--lsp" },
	filetypes = { "rv", "revo" },
	root_markers = { "lib.json", "exe.json", ".git" },
})
vim.lsp.enable("revo")

vim.treesitter.language.register("revo", { "rv", "revo" })
local revo_ts_path = vim.fn.expand("~") .. "/projects/tree-sitter-revo"
if vim.fn.isdirectory(revo_ts_path) == 1 then
	vim.opt.runtimepath:append(revo_ts_path)
	pcall(vim.treesitter.language.add, "revo", { path = revo_ts_path .. "/revo.so" })
end

-- enable standard lsp servers
for _, name in ipairs({
	"c3_lsp",
	"clangd",
	"gopls",
	"jdtls",
	"biome",
	"ts_ls",
	"rust_analyzer",
}) do
	vim.lsp.enable(name)
end

-- servers with custom settings
for name, conf in pairs({
	lua_ls = {
		settings = {
			Lua = {
				workspace = {
					library = {
						vim.api.nvim_get_runtime_file("", true),
						"${3rd}/love2d/library",
					},
				},
				telemetry = { enable = false },
			},
		},
	},
	zls = {
		settings = { zls = { enable_build_on_save = true } },
	},
	ols = {
		init_options = { enable_fake_methods = true },
	},
}) do
	vim.lsp.config(name, conf)
	vim.lsp.enable(name)
end
