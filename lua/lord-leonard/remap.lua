vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("t", "<C-t>", "<C-\\><C-n>:ToggleTerm<CR>", { noremap = true })
vim.keymap.set("n", "<C-t>", ":ToggleTerm<CR>A")
