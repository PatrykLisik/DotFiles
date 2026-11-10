vim.g.mapleader = " "
vim.keymap.set("n", "<leader>", "<nop>")

-- paste without replace
vim.keymap.set("x", "p", [["_d+P]])

vim.keymap.set("n", "Q", "<nop>")

--rename word under the key
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- vim.keymap.set({ "v", "n" }, "p", '"*p')

--vim.keymap.set({"n", "v"}, "pp", "*p")
vim.keymap.set({ "x", "v" }, "x", '"*x :let @+=@*<CR>', { noremap = true, silent = true })
vim.keymap.set({ "v", "n" }, "d", '"_d')
vim.keymap.set({ "v", "n" }, "D", 'd$', { noremap = true, silent = true })
-- vim.keymap.set({ "v", "n" }, "y", '"*y :let @+=@*<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "yy", '"*yy :let @+=@*<CR>', { noremap = true, silent = true })

--select all
vim.keymap.set({ "n" }, "<leader>as", "ggVG")

--moving to different buferrs fast
vim.api.nvim_set_keymap('n', '<leader>l', '<C-W>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>h', '<C-W>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-W>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-W>k', { noremap = true })

--terminal
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { noremap = true })

vim.keymap.set("x", "/", "<Esc>/\\%V")
