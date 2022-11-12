local keymap = vim.keymap

keymap.set("n", "<leader>gs", ":Git<CR>", { silent = true })
keymap.set("n", "<leader>gd", ":Gdiff<CR>", { silent = true })
keymap.set("n", "<leader>gc", ":Git commit<CR>", { silent = true })
keymap.set("n", "<leader>gb", ":Git blame<CR>", { silent = true })
keymap.set("n", "<leader>gl", ":Gclog<CR>", { silent = true })
keymap.set("n", "<leader>gw", ":Gbrowse<CR>", { silent = true })
keymap.set("n", "<leader>gp", ":Git push<CR>", { silent = true })
