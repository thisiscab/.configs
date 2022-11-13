local g = vim.g
local keymap = vim.keymap

keymap.set("n", "<Leader>mp", ":MarkdownPreviewToggle<CR>")

g.mkdp_theme = 'dark'
