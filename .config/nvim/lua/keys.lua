local map = vim.keymap.set

local opts = { noremap = true, silent = true }
-- keybindings
-- map("n", "<cr>", "o<esc>", opts)
--map('n', '<space>', 'i<space><esc>', opts)

-- buffers keybindings
map("n", "[[", "<Cmd>:bprevious<CR>", opts)
map("n", "]]", "<Cmd>:bnext<CR>", opts)
map("n", "<leader><leader>", "<Cmd>:bd<CR>", opts)

--telescope keybinding
local builtin = require("telescope.builtin")
map("n", "<space><space>", builtin.find_files, opts)
map("n", "<space>b", builtin.buffers, opts)
map("n", "<space>o", builtin.oldfiles, opts)
map("n", "<space>m", builtin.marks, opts)
map("n", "<space>t", builtin.treesitter, opts)
map("n", "<space>g", builtin.live_grep, opts)
-- map("n", "<leader>f", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)

-- trouble plugin keybindings
map("n", "<space>q", "<Cmd>:TroubleToggle<CR>", opts)

map("n", "<space>e", "<Cmd>:lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", opts)
-- map("n", "gD", vim.lsp.buf.declaration, opts)
-- map("n", "gd", vim.lsp.buf.definition, opts)
-- map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<space>rn", vim.lsp.buf.rename, opts)
