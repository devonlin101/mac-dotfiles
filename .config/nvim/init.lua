-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.python3_host_prog = "/usr/bin/python3"

require("options")
require("plugins")
require("reqsetup")
require("keys")
require("felineconfig")
require("lspsettings")
require("nvimcmp")
