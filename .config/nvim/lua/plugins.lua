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

	-- "Shatur/neovim-ayu",
	-- "hrsh7th/cmp-vsnip",
	-- "hrsh7th/vim-vsnip",
	-- { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	-- { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" },
	-- {
	-- 	"smoka7/hop.nvim",
	-- 	version = "*",
	-- },
	-- {
	-- 	"nvim-telescope/telescope.nvim",
	-- 	tag = "0.1.4",
	-- 	dependencies = { { "nvim-lua/plenary.nvim" } },
	-- },
	-- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- {
	-- 	"utilyre/barbecue.nvim",
	-- 	name = "barbecue",
	-- 	version = "*",
	-- 	dependencies = {
	-- 		"SmiteshP/nvim-navic",
	-- 		"nvim-tree/nvim-web-devicons", -- optional dependency
	-- 	},
	-- },
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	event = "InsertEnter",
	-- 	opts = {},
	-- },
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
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
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
					disable = { "markdown" }, -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
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
