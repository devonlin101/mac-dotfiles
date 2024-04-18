-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "clangd", "rust_analyzer", "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities,
	})
end

-- luasnip setup
local luasnip = require("luasnip")
-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- nvim-cmp setup
local cmp = require("cmp")
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm.done())
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "abbr", "menu", "kind" },
		format = function(entry, item)
			-- Define menu shorthand for different completion sources.
			local menu_icon = {
				nvim_lsp = "NLSP",
				nvim_lua = "NLUA",
				luasnip = "LSNP",
				buffer = "BUFF",
				path = "PATH",
			}
			-- Set the menu "icon" to the shorthand for each completion source.
			item.menu = menu_icon[entry.source.name]

			-- Set the fixed width of the completion menu to 60 characters.
			-- fixed_width = 20

			-- Set 'fixed_width' to false if not provided.
			fixed_width = fixed_width or false

			-- Get the completion entry text shown in the completion window.
			local content = item.abbr

			-- Set the fixed completion window width.
			if fixed_width then
				vim.o.pumwidth = fixed_width
			end

			-- Get the width of the current window.
			local win_width = vim.api.nvim_win_get_width(0)

			-- Set the max content width based on either: 'fixed_width'
			-- or a percentage of the window width, in this case 20%.
			-- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
			local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

			-- Truncate the completion entry text if it's longer than the
			-- max content width. We subtract 3 from the max content width
			-- to account for the "..." that will be appended to it.
			if #content > max_content_width then
				item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
			else
				item.abbr = content .. (" "):rep(max_content_width - #content)
			end
			return item
		end,
	},
	mapping = cmp.mapping.preset.insert({
		-- ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
		-- ["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
		-- C-b (back) C-f (forward) for snippet placeholder navigation.
		-- ["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
