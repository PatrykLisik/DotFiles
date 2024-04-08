vim.g.mapleader = " "
vim.keymap.set("n", "<leader>po", vim.cmd.Ex)
--vim.api.nvim_set_option("clipboard","unnamed")

vim.keymap.set("n", "<leader>", "<nop>")

--vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--pvim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
--vim.keymap.set("i", "<C-c>", "<Esc>")
--vim.keymap.set("n", "<C-d>", "<C-d>zz")
--vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- paste witout replace
vim.keymap.set("x", "p", [["_d+P]])

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

--rename word under the key
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- newtrw

--vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
-- Breaks netrw if not 0
vim.g.netrw_browse_split = 0
--vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25

vim.keymap.set("n","<leader>e", vim.cmd.Lexplore)

--adad adadad a

---No buffer overwriting on , paste, delete, cut in normal mode is delete
vim.keymap.set({"n", "v"},"L", "e")
vim.keymap.set({"n","v"},"H", "b")
vim.keymap.set({"v","n"}, "J", "j")
-- LSP uses capital K to show tool tips
--vim.keymap.set({"v", "n"}, "K", "k")


vim.keymap.set({"v", "n"}, "p", '"*p')
--vim.keymap.set({"n", "v"}, "pp", "*p")
vim.keymap.set({"x", "v"}, "x", '"*x :let @+=@*<CR>', {noremap=true, silent=true})
vim.keymap.set({"v", "n"}, "d", '"_d')
vim.keymap.set({"v", "n"}, "D", '_d$', {noremap=true, silent=true})
vim.keymap.set({"v", "n"}, "y", '"*y :let @+=@*<CR>', {noremap=true, silent=true})
vim.keymap.set( "n", "yy", '"*yy :let @+=@*<CR>', {noremap=true, silent=true})

--select all
vim.keymap.set({"n"}, "<leader>as" , "ggVG")

--moves in insert mode
vim.keymap.set("i","<C-h>", "<Left>", {noremap=true})
vim.keymap.set("i","<C-j>", "<Down>", {noremap=true})
vim.keymap.set("i","<C-k>", "<Up>", {noremap=true})
vim.keymap.set("i","<C-l>", "<Right>", {noremap=true})

--ctrl backspace to detele whole word
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {noremap = true})

--moving to different buferrs fast 
vim.api.nvim_set_keymap('n', '<leader>l', '<C-W>l', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>h', '<C-W>h', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>j', '<C-W>j', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>k', '<C-W>k', {noremap=true})

-- vim.cmd("Spell")
