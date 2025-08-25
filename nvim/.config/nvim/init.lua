local g = vim.g
local opt = vim.opt
local o = vim.o
local keymap = vim.keymap

-- Performance optimizations
opt.updatetime = 250
opt.timeoutlen = 300
opt.lazyredraw = true
opt.synmaxcol = 240
opt.redrawtime = 10000

-- Memory optimizations
opt.hidden = true
opt.history = 100
opt.lazyredraw = true
opt.regexpengine = 1
opt.ttyfast = true

-- Leader key
g.mapleader = " "
g.maplocalleader = " "

-- Clipboard
opt.clipboard = "unnamedplus"

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2

-- Search
opt.ignorecase = true
opt.infercase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
-- Show search count message when searching
opt.shortmess:remove("S")

-- Force search count update after search navigation
vim.api.nvim_create_autocmd("CmdlineLeave", {
	pattern = { "/", "?" },
	callback = function()
		vim.schedule(function()
			if vim.v.hlsearch == 1 then
				local ok, result = pcall(vim.fn.searchcount, { recompute = 1 })
				if ok and result and result.total and result.total > 0 then
					vim.api.nvim_echo(
						{ { string.format("[%d/%d]", result.current, result.total), "Search" } },
						false,
						{}
					)
				end
			end
		end)
	end,
})

-- UI
opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.pumheight = 10
opt.showmode = false

-- Files
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Splits
opt.splitright = true
opt.splitbelow = true

vim.cmd("set iskeyword+=-")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup("plugins", {
	defaults = {
		lazy = false, -- Don't lazy load by default to avoid filetype detection issues
		version = false,
	},
	install = { colorscheme = { "gruvbox-material" } },
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- Load configurations
require("config.keymaps")

-- Keymaps are now handled by which-key plugin configuration

-- Custom
keymap.set("n", "<Leader>rtw", ":%s/\\s\\+$//e<CR>")
keymap.set("n", "<Leader>snr", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>")
keymap.set("n", "<Leader>pwd", ':echo expand("%:p")<CR>')
keymap.set("n", "<Leader>cs", ":noh<CR>")

-- Buffer Navigation
keymap.set("n", "<Leader>k", ":bnext<CR>")
keymap.set("n", "<Leader>j", ":bprevious<CR>")
keymap.set("n", "<Leader>l", ":b#<CR>")
keymap.set("n", "<Leader>bq", ":bp <BAR> bd #<CR>")

-- I'm stupid
vim.cmd("command! WQ wq")
vim.cmd("command! Wq wq")
vim.cmd("command! W w")
vim.cmd("command! Q q")

-- Sorting
keymap.set("n", "<Leader>ss", "vip:sort u<CR>")
keymap.set("n", "<Leader>SS", "vip:sort! u<CR>")
keymap.set("v", "<Leader>ss", ":sort u<CR>")
keymap.set("v", "<Leader>SS", ":sort! u<CR>")

-- keymap.set("n", "<leader>rr", ":source $MYVIMRC<CR>")

keymap.set("n", "<leader>t", function()
	vim.cmd("cd %:p:h")
	vim.cmd("terminal")
	vim.cmd("startinsert")
end)

-- Git commit settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "gitrebase" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
		vim.opt_local.textwidth = 72
		vim.opt_local.colorcolumn = "50,72"
	end,
})

-- Ensure git commit messages get proper highlighting
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "COMMIT_EDITMSG", "MERGE_MSG", "*.git/COMMIT_EDITMSG" },
	callback = function()
		vim.bo.filetype = "gitcommit"
	end,
})

