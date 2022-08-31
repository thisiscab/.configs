" hello front end masters
set path+=**

highlight MyGroup ctermfg=red
syntax keyword MyGroup cout

" Nice menu when typing `:find *.py`
" set wildmode=longest,list,full
" set wildmenu

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

set clipboard+=unnamed
set number

" ========== Text Formatting ==========
    set ignorecase          " case insensitive by default
    set infercase           " case inferred by default
    set smartcase           " if there are caps, go case-sensitive
    set expandtab           " no real tabs please!
    set nowrap              " do not wrap line
    set shiftround          " when at 3 spaces, and I hit > ... go to 4, not 5
    set shiftwidth=4        " auto-indent amount when using cindent, >>, << and stuff like that
    set softtabstop=4       " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
    set tabstop=8           " real tabs should be 8, and they will show with set list on
    set complete+=kspell    " Allow spelling completing when spell is activated
    set completeopt=menu,menuone,noselect

call plug#begin('~/.vim/plugged')

" Attempt
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'mbbill/undotree'
Plug 'tpope/vim-dispatch'
Plug 'gruvbox-community/gruvbox'

" telescope requirements...
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-fzy-native.nvim'

" prettier
Plug 'sbdchd/neoformat'
Plug 'editorconfig/editorconfig-vim'

Plug 'hashivim/vim-terraform'
let g:terraform_fmt_on_save=1
let g:terraform_unindent_heredoc=1

" Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
" " required by fugitive for :gbrowse
Plug 'tpope/vim-rhubarb'
Plug 'tomtom/tcomment_vim'
" " v Must come before vim-makdown
" Plug 'godlygeek/tabular'
" " Plug 'plasticboy/vim-markdown'
" " Plug 'iamcco/markdown-preview.nvim'
" " ^ Manually have to run: :call mkdp#util#install()
Plug 'christoomey/vim-tmux-navigator'
" Plug 'mattn/gist-vim'
" " Required for gist-vim
" Plug 'mattn/webapi-vim'
" " " end
" Plug 'rking/ag.vim'
Plug 'jremmen/vim-ripgrep'
" Plug 'w0rp/ale'
" Plug 'elzr/vim-json'
" Plug 'chrisbra/csv.vim'

call plug#end()

let mapleader = " "

nnoremap <Leader>rtw :%s/\s\+$//e<CR>
nnoremap <Leader>snr :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <leader>pwd :echo expand('%:p')<cr>
nnoremap <Leader>e <ESC>:so ~/.config/nvim/init.vim<CR><CR>
nnoremap <leader>cs :noh<CR>

nnoremap :W <ESC>:w
nnoremap :Q <ESC>:q

" hrsh7th/nvim-cmp
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" ----- Buffer Navigation -----
nmap <leader>k :bnext<CR>
" Move to the previous buffer
nmap <leader>j :bprevious<CR>
nmap <leader>l :b#<CR>
nmap <leader>bq :bp <BAR> bd #<CR>

if (has("termguicolors"))
  set termguicolors
  " set t_8f=^[[38;2;%lu;%lu;%lum  " Needed in tmux
  " set t_8b=^[[48;2;%lu;%lu;%lum  " Ditto
endif
set background=dark
colorscheme gruvbox

augroup EditVim
    autocmd!

    " ----- Filetypes -----
    au FileType gitcommit setlocal spell textwidth=72
    au FileType markdown setlocal spell shiftwidth=2 softtabstop=2 tabstop=2
    au FileType python set foldenable
    au FileType ruby setlocal shiftwidth=2 softtabstop=2 tabstop=2
    au FileType yaml setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
    au FileType sql setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
    au FileType typescript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
    au FileType json setlocal shiftwidth=2 softtabstop=2 tabstop=2
    au FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END

autocmd Syntax * syntax keyword GreenMarker NOTE note
autocmd Syntax * syntax keyword YellowMarker TODO todo
autocmd Syntax * syntax keyword RedMarker FIXME XXX fixme xxx
highlight GreenMarker cterm=reverse ctermfg=108 ctermbg=235 gui=bold guifg=#8ec07c guibg=#282828
highlight YellowMarker cterm=bold ctermfg=235 ctermbg=214 gui=bold guifg=#282828 guibg=#fabd2f
highlight RedMarker cterm=bold ctermfg=235 ctermbg=167 gui=bold guifg=#282828 guibg=#fb4934
