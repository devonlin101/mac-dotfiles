--vim.cmd.colorscheme("catppuccin-macchiato")
-- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
require("everforest").load()
require("hop").setup()
require("Comment").setup()
require("bufferline").setup({})
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

-- require("ufo").setup({
-- 	provider_selector = function(bufnr, filetype, buftype)
-- 		return { "treesitter", "indent" }
-- 	end,
-- })
-- require("telescope").load_extension("fzf")

-- require("lint").linters_by_ft = {
-- 	markdown = { "vale" },
-- }

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	callback = function()
-- 		require("lint").try_lint()
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format({ bufnr = args.buf })
--   end,
-- })

-- require("nvim-treesitter.configs").setup({
-- 	-- A list of parser names, or "all" (the five listed parsers should always be installed)
-- 	-- ensure_installed = { "c", "cpp", "cmake", "lua", "make", "vim", "vimdoc", "typescript", "rust" },
--
-- 	-- Install parsers synchronously (only applied to `ensure_installed`)
-- 	-- sync_install = true,
--
-- 	-- Automatically install missing parsers when entering buffer
-- 	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
-- 	-- auto_install = true,
--
-- 	-- List of parsers to ignore installing (or "all")
-- 	-- ignore_install = { "javascript" },
--
-- 	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
-- 	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
--
-- 	highlight = {
-- 		enable = true,
--
-- 		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
-- 		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
-- 		-- the name of the parser)
-- 		-- list of language that will be disabled
-- 		-- disable = { "c", "rust" },
-- 		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
-- 		disable = function(lang, buf)
-- 			local max_filesize = 100 * 1024 -- 100 KB
-- 			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
-- 			if ok and stats and stats.size > max_filesize then
-- 				return true
-- 			end
-- 		end,
--
-- 		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
-- 		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
-- 		-- Using this option may slow down your editor, and you may see some duplicate highlights.
-- 		-- Instead of true it can also be a list of languages
-- 		additional_vim_regex_highlighting = false,
-- 	},
-- })
---- hide lsp inlint error messages
--vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--  vim.lsp.diagnostic.on_publish_diagnostics, {
--  virtual_text = false
--}
--)
-- -- Utilities for creating configurations
-- local util = require("formatter.util")
-- local defaults = require("formatter.defaults")
-- -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
-- require("formatter").setup({
-- 	-- Enable or disable logging
-- 	logging = true,
-- 	-- Set the log level
-- 	log_level = vim.log.levels.WARN,
-- 	-- All formatter configurations are opt-in
-- 	filetype = {
-- 		-- Formatter configurations for filetype "lua" go here
-- 		-- and will be executed in order
-- 		lua = {
-- 			-- "formatter.filetypes.lua" defines default configurations for the
-- 			-- "lua" filetype
-- 			require("formatter.filetypes.lua").stylua,
--
-- 			-- You can also define your own configuration
-- 			function()
-- 				-- Supports conditional formatting
-- 				if util.get_current_buffer_file_name() == "special.lua" then
-- 					return nil
-- 				end
--
-- 				-- Full specification of configurations is down below and in Vim help
-- 				-- files
-- 				return {
-- 					exe = "stylua",
-- 					args = {
-- 						"--search-parent-directories",
-- 						"--stdin-filepath",
-- 						util.escape_path(util.get_current_buffer_file_path()),
-- 						"--",
-- 						"-",
-- 					},
-- 					stdin = true,
-- 				}
-- 			end,
-- 		},
-- 		c = {
-- 			-- require("formatter.filetypes.c").clangformat,
-- 			function()
-- 				return {
-- 					exe = "clang-format",
-- 					args = {
-- 						"-assume-filename",
-- 						util.escape_path(util.get_current_buffer_file_name()),
-- 					},
-- 					stdin = true,
-- 					try_node_modules = true,
-- 				}
-- 			end,
-- 		},
-- 		cpp = {
-- 			-- require("formatter.filetypes.cpp").clangformat,
-- 			function()
-- 				return {
-- 					exe = "clang-format",
-- 					args = {
-- 						"-assume-filename",
-- 						util.escape_path(util.get_current_buffer_file_name()),
-- 					},
-- 					stdin = true,
-- 					try_node_modules = true,
-- 				}
-- 			end,
-- 		},
-- 		cmake = {
-- 			-- require("formatter.filetypes.cmake").cmakeformat,
-- 			function()
-- 				return {
-- 					exe = "cmake-format",
-- 					args = {
-- 						"-",
-- 					},
-- 					stdin = true,
-- 				}
-- 			end,
-- 		},
-- 		rust = {
-- 			function()
-- 				return {
-- 					exe = "rustfmt",
-- 					args = { "--edition 2021" },
-- 					stdin = true,
-- 				}
-- 			end,
-- 		},
-- 		javascript = {
-- 	      		function()
-- 				return {
-- 					exe = "biome",
-- 					args = {
-- 						"format",
-- 						"--stdin-file-path",
-- 						util.escape_path(util.get_current_buffer_file_path()),
-- 					},
-- 					stdin = true,
-- 				}
-- 			end,
-- 		},
-- 		typescriptreact = {},
-- 		-- Use the special "*" filetype for defining formatter configurations on
-- 		-- any filetype
-- 		["*"] = {
-- 			-- "formatter.filetypes.any" defines default configurations for any
-- 			-- filetype
-- 			require("formatter.filetypes.any").remove_trailing_whitespace,
-- 		},
-- 	},
-- })
--format on save code
-- vim.cmd([[
-- augroup FormatAutogroup
--   autocmd!
--   autocmd BufWritePost * FormatWrite
-- augroup END
-- ]])
