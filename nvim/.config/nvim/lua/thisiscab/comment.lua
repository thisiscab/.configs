require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

require('nvim_comment').setup({
  hook = function()
    require('ts_context_commentstring').update_commentstring()
  end
})
