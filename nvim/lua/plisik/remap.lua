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

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- newtrw

--vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
--vim.g.netrw_browse_split = 4
--vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25

local  netrw_liststyle = 3
vim.keymap.set("n","<leader>e", vim.cmd.Lexplore)

--adad adadad a

---No bufer overwriting on , pase, delete, cut in normal mode is delete
vim.keymap.set({"n", "v"},"L", "e")
vim.keymap.set({"n","v"},"H", "b")
vim.keymap.set({"v","n"}, "J", "j")
--vim.keymap.set({"v", "n"}, "K", "k")


vim.keymap.set({"v", "n"}, "p", '"*p')
--vim.keymap.set({"n", "v"}, "pp", "*p")
vim.keymap.set({"x", "v"}, "x", '"*x :let @+=@*<CR>', {noremap=true, silent=true})
vim.keymap.set({"v", "n"}, "d", '"_d')
vim.keymap.set({"v", "n"}, "D", '_d$', {noremap=true, silent=true})
vim.keymap.set({"v", "n"}, "y", '"*y :let @+=@*<CR>', {noremap=true, silent=true})
vim.keymap.set( "n", "yy", '"*yy :let @+=@*<CR>', {noremap=true, silent=true})

