local g = vim.g
local opt = vim.opt
local keymap = vim.keymap

g.mapleader = " "

opt.clipboard = "unnamed"

opt.ignorecase = true
opt.infercase = true
opt.smartcase = true
opt.expandtab = true

opt.wrap = false
opt.shiftround = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.softtabstop = 4

opt.number = true
opt.relativenumber = true

opt.complete = "kspell"

local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.config/nvim/plugged")

Plug("neovim/nvim-lspconfig")

Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/nvim-cmp")

-- Plug("glepnir/lspsaga.nvim")

-- Neovim Tree shitter
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
-- Plug("nvim-treesitter/playground")

-- Snippets
Plug("L3MON4D3/LuaSnip")
Plug("saadparwaiz1/cmp_luasnip")
Plug("rafamadriz/friendly-snippets")

Plug("nvim-lua/plenary.nvim")

-- fun
Plug("petertriho/cmp-git")

Plug("hrsh7th/cmp-calc")
Plug("hrsh7th/cmp-emoji")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
-- Plug("uga-rosa/cmp-dictionary")
-- /fun

-- Plug("mbbill/undotree")
Plug("gruvbox-community/gruvbox")

-- prettier
Plug("sbdchd/neoformat")
Plug("editorconfig/editorconfig-vim")

Plug("hashivim/vim-terraform", { ["for"] = "terraform" })

Plug("nvim-telescope/telescope.nvim", { ["tag"] = "0.1.0" })
Plug("nvim-telescope/telescope-ui-select.nvim")

Plug("vim-airline/vim-airline")
Plug("tpope/vim-fugitive")
Plug("shumphrey/fugitive-gitlab.vim")
-- " " required by fugitive for :gbrowse
Plug("tpope/vim-rhubarb")
Plug("tomtom/tcomment_vim")
Plug("iamcco/markdown-preview.nvim", { ["do"] = "mkdp#util#install()", ["for"] = { "markdown", "vim-plug" } })

Plug("christoomey/vim-tmux-navigator")
Plug("digitaltoad/vim-pug", { ["for"] = "pug" })
-- Plug("jremmen/vim-ripgrep")

vim.call("plug#end")

opt.termguicolors = true
opt.background = "dark"
vim.cmd("colorscheme gruvbox")

keymap.set("n", "<Leader>rtw", ":%s/\\s\\+$//e<CR>")
keymap.set("n", "<Leader>snr", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>")
keymap.set("n", "<Leader>pwd", ':echo expand("%:p")<CR>')
keymap.set("n", "<Leader>ss", ":luafile $MYVIMRC<CR>")
keymap.set("n", "<Leader>cs", ":noh<CR>")

-- ----- Buffer Navigation -----
keymap.set("n", "<Leader>k", ":bnext<CR>")
-- Move to the previous buffer
keymap.set("n", "<Leader>j", ":bprevious<CR>")
keymap.set("n", "<Leader>l", ":b#<CR>")
keymap.set("n", "<Leader>bq", ":bp <BAR> bd #<CR>")

-- autocmd Syntax * syntax keyword GreenMarker NOTE note
-- autocmd Syntax * syntax keyword YellowMarker TODO todo
-- autocmd Syntax * syntax keyword RedMarker FIXME XXX fixme xxx
-- highlight GreenMarker cterm=reverse ctermfg=108 ctermbg=235 gui=bold guifg=#8ec07c guibg=#282828
-- highlight YellowMarker cterm=bold ctermfg=235 ctermbg=214 gui=bold guifg=#282828 guibg=#fabd2f
-- highlight RedMarker cterm=bold ctermfg=235 ctermbg=167 gui=bold guifg=#282828 guibg=#fb4934

require("thisiscab")
