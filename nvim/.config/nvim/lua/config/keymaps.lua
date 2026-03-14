vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Save file with <leader>qw
vim.keymap.set("n", "<leader>qw", "<cmd>w<CR>", { noremap = true, silent = true, desc = "Save file" })
