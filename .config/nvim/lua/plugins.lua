local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"lewis6991/gitsigns.nvim",
	"freddiehaddad/feline.nvim",
	"hrsh7th/nvim-cmp", -- Autocompletion plugin
	"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
	"hrsh7th/vim-vsnip-integ",
	"christoomey/vim-tmux-navigator",
	"rafamadriz/friendly-snippets",
	{ "echasnovski/mini.nvim", version = "*" },
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		-- or                              , branch = '0.1.x',
		-- dependencies = { "nvim-lua/plenary.nvim" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				-- italics = true,
				-- 	dim_inactive_windows = true,
				-- 	diagnostic_text_hightlight = true,
			})
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"c",
					"cpp",
					"cmake",
					"javascript",
					"html",
					"lua",
					"markdown",
					"markdown_inline",
					"rust",
					"sql",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
				},
				sync_install = false,
				highlight = {
					enable = true,
					disable = {}, -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
					-- disable = function(lang, buf)
					-- 	local max_filesize = 100 * 1024 -- 100 KB
					-- 	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					-- 	if ok and stats and stats.size > max_filesize then
					-- 		return true
					-- 	end
					-- end,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- Everything in opts will be passed to setup()
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				json = { "biome" },
				markdown = { "mdformat" },
				sh = { "beautysh" },
				cpp = { "clang_format" },
				cmake = { "cmake_format" },
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				rust = { "rustfmt" },
			},
			-- Use the "*" filetype to run formatters on all filetypes.
			["*"] = { "codespell" },
			-- Use the "_" filetype to run formatters on filetypes that don't
			-- have other formatters configured.
			["_"] = { "trim_whitespace" },
			-- Set up format-on-save
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
			-- Customize formatters
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}

local opts = {}

require("lazy").setup(plugins, opts)

--======================================================================================================

--vim.cmd.colorscheme("catppuccin-macchiato")
-- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

-- mini.nvim setup
-- require("mini.comment").setup()
require("mini.surround").setup() --sa: add surrounding sd: delete surrounding sr: replace surrounding
require("mini.fuzzy").setup()
require("mini.tabline").setup()
require("mini.pairs").setup()
require("mini.cursorword").setup()
require("mini.files").setup({})
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
