-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.g.python3_host_prog = "/usr/bin/python3"
vim.treesitter.language.register("markdown", { "mdx" })

require("options")
require("plugins")
require("keys")
require("lspsettings")
require("nvimcmp")
-- require("felineconfig")
-- require("reqsetup")
-- require("ufo")
