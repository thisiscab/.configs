local keymap = vim.keymap

-- Better defaults
keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==")
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==")
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi")
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi")
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv")
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv")

-- Better paste
keymap.set("x", "p", [["_dP]])

-- Clear search with <esc>
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- Save file
keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>")

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- Resize with arrows
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>")
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>")
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- Terminal
keymap.set("t", "<esc>", "<c-\\><c-n>")
keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>")
keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>")
keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>")
keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>")

-- Add empty lines
keymap.set("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
keymap.set("n", "go", "<Cmd>call append(line('.'), repeat([''], v:count1))<CR>")

return {}