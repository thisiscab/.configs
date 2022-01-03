" Search from the root directory
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1

nmap <leader>sf :CtrlP<CR>
nmap <leader>sr :CtrlPMRU<CR>
nmap <leader>sl :CtrlP .<CR>
nmap <leader>sa :CtrlPMixed<CR>
" Search from all opened buffers
nmap <leader>sb :CtrlPBuffer<CR>

if executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_use_caching = 0

    let g:ctrlp_user_command = 'rg %s --files --color=never --glob "!{.git}" --hidden'
endif
