--vim.cmd.colorscheme("catppuccin-macchiato")
-- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

-- mini.nvim setup
require("mini.comment").setup()
require("mini.surround").setup() --sa: add surrounding sd: delete surrounding sr: replace surrounding
require("mini.tabline").setup()
require("mini.pairs").setup()
require("mini.cursorword").setup()
require("mini.jump2d").setup({
	mappings = {
		start_jumping = "f",
	},
})
-- require("mini.jump").setup()

require("everforest").load()
-- require("hop").setup()
require("gitsigns").setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("mason").setup({
	opts = {
		ensure_installed = {
			"typescript-language-server",
		},
	},
})
require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	renderer = {
		highlight_opened_files = "all",
		indent_markers = {
			enable = true,
		},
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"clangd",
		"cmake",
		"bashls",
		"dockerls",
		"tsserver",
		"lua_ls",
		"prismals",
		"rust_analyzer",
	},
	automatic_installation = true,
})
require("ibl").setup({
	scope = {
		show_exact_scope = true,
		highlight = { "Function", "Label" },
		include = {
			node_type = { ["*"] = { "*" } },
		},
	},
})
require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
		file_ignore_patterns = {
			"node_modules",
			"build",
			"dist",
			"yarn.lock",
			".gitignore",
		},
	},
	pickers = {
		find_files = {
			hidden = true, --will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
		},
	},
	extensions = {
		file_browser = {
			-- cwd = vim.g.documentos,
			hijack_netrw = true,
			select_buffer = true,
			hidden = true,
			depth = 2,
		},
	},
})
require("telescope").load_extension("file_browser")
