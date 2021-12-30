" hello front end masters
set path+=**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
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

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
" required by fugitive for :gbrowse
Plug 'tpope/vim-rhubarb'
Plug 'tomtom/tcomment_vim'
" v Must come before vim-makdown
Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
" Plug 'iamcco/markdown-preview.nvim'
" ^ Manually have to run: :call mkdp#util#install()
Plug 'christoomey/vim-tmux-navigator'
Plug 'mattn/gist-vim'
" Required for gist-vim
Plug 'mattn/webapi-vim'
" " end
Plug 'rking/ag.vim'
Plug 'w0rp/ale'
Plug 'elzr/vim-json'
Plug 'chrisbra/csv.vim'

call plug#end()

let mapleader = " "

nnoremap <Leader>rtw :%s/\s\+$//e<CR>
nnoremap <Leader>snr :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <leader>pwd :echo expand('%:p')<cr>
nnoremap <Leader>sv <ESC>:so $MYVIMRC<CR>
nnoremap <leader>ev :e ~/.vimrc<CR>

nnoremap :W <ESC>:w
nnoremap :Q <ESC>:q

" ----- Buffer Navigation -----
    nmap <leader>l :bnext<CR>
    " Move to the previous buffer
    nmap <leader>h :bprevious<CR>
    nmap <leader>bq :bp <BAR> bd #<CR>
    nmap <leader>bp :b#<CR>

" ----- VimAirline -----
    let g:airline#extensions#ale#enabled = 1
    let g:airline#extensions#tabline#enabled = 1      " Enable the list of buffers
    let g:airline#extensions#tabline#fnamemod = ':t'  " Show just the filename
    let g:airline#extensions#tabline#formatter = 'default'

" ----- CtrlP -----
    " Search from the root directory
    let g:ctrlp_working_path_mode = 'ra'

    nmap <leader>sf :CtrlP<CR>
    nmap <leader>sr :CtrlPMRU<CR>
    nmap <leader>sl :CtrlP .<CR>
    nmap <leader>sa :CtrlPMixed<CR>
    " Search from all opened buffers
    nmap <leader>sb :CtrlPBuffer<CR>

" ----- Fugitive -----
    nnoremap <silent> <leader>gs :Git<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Git commit<CR>
    nnoremap <silent> <leader>gb :Git blame<CR>
    nnoremap <silent> <leader>gl :Gclog<CR>
    nnoremap <silent> <leader>gw :GBrowse<CR>
    nnoremap <silent> <leader>gp :Git push<CR>

if (has("termguicolors"))
  set termguicolors
  " set t_8f=^[[38;2;%lu;%lu;%lum  " Needed in tmux
  " set t_8b=^[[48;2;%lu;%lu;%lum  " Ditto
endif
set background=dark
colorscheme gruvbox

highlight RedGroup ctermfg=1
highlight GreenGroup ctermfg=2
highlight YellowGroup ctermfg=3
match Redgroup '\<TODO\|FIXME\>'
2match GreenGroup '\<NOTE\>'
