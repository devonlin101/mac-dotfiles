local map = vim.keymap.set

local opts = { noremap = true, silent = true }
-- keybindings
map("n", "<cr>", "o<esc>", opts)
--map('n', '<space>', 'i<space><esc>', opts)

-- bufferline keybindings
map("n", "[[", "<Cmd>BufferLineCyclePrev<CR>", opts)
map("n", "]]", "<Cmd>BufferLineCycleNext<CR>", opts)
map("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
map("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
map("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
map("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
map("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
map("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
map("n", "<leader>0", "<Cmd>BufferLineCloseOthers <CR>", opts)
map("n", "<leader>=", "<Cmd>BufferLineTogglePin <CR>", opts)
map("n", "[]", "<Cmd>BufferLineMoveNext<CR>", opts)
map("n", "][", "<Cmd>BufferLineMovePrev<CR>", opts)
map("n", "<leader><leader>", "<Cmd>:bd<CR>", opts)

--telescope keybinding
local builtin = require("telescope.builtin")
map("n", "<space><space>", builtin.find_files, opts)
map("n", "<space>b", builtin.buffers, opts)
map("n", "<space>o", builtin.oldfiles, opts)
map("n", "<space>m", builtin.marks, opts)
map("n", "<space>t", builtin.treesitter, opts)
map("n", "<space>g", builtin.live_grep, opts)
map("n", "<leader>f", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)

--nvim tree keybindings
map("n", "<space>e", "<cmd>:NvimTreeFindFileToggle<CR>", opts)

-- trouble plugin keybindings
map("n", "<space>q", "<Cmd>:TroubleToggle<CR>", opts)

-- hop.nvim keybindings
-- place this in one of your configuration file(s)
local hop = require("hop")
local directions = require("hop.hint").HintDirection
map("", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, { remap = true })
map("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })
map("", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
end, { remap = true })
map("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
end, { remap = true })

-- map("n", "gD", vim.lsp.buf.declaration, opts)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<space>rn", vim.lsp.buf.rename, opts)
