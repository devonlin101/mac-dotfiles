local options = {

	--	termguicolors = true,
	backup = false,
	number = true,
	showmode = false,
	relativenumber = true,
	mouse = "a",
	ignorecase = true,
	smartcase = true,
	hlsearch = false,
	wrap = true,
	breakindent = true,
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	scrolloff = 4,
	signcolumn = "yes",
	syntax = "ON",
	tgc = true,
	ph = 15,
	pumwidth = 10,
	incsearch = true,
	splitright = true,
	splitbelow = true,
	linebreak = true,
	hidden = true,
	timeoutlen = 1000,
	updatetime = 200,
	ttimeoutlen = 0,
	swapfile = false,
	foldcolumn = "1", -- '0' is not bad
	foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
	foldlevelstart = 99,
	foldenable = true,
	cursorline = true,

	-- cmdheight = 0,
	-- laststatus = 3,
	-- background = "dark",
	-- foldmethod = "expr",
	-- foldexpr = "nvim_treesitter#foldexpr()",
	-- foldenable = false,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end
