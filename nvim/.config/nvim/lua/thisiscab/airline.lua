local gset = vim.api.nvim_set_var

gset("airline#extensions#tabline#enabled", 1)
gset("airline#extensions#tabline#fnamemod", ":t")
gset("airline#extensions#tabline#formatter", "default")
