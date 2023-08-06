local lsp = require('lsp-zero')
lsp.preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
 
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', '<C-Space>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<C-Space>', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
end)

lsp.ensure_installed({
	-- Replace these with whatever servers you want to install
	"marksman",
	"pylsp",
	"dockerls",
})


-- (Optional) Configure lua language server for neovim
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require('lspconfig').pylsp.setup{}
lsp.setup()
