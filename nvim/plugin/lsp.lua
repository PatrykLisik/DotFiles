local lsp = require('lsp-zero')
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

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

-- Use Enter to confirm completion
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = false}),
  })
})
--Preselect first item
cmp.setup({
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
})

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  })
})

lsp.ensure_installed({
	-- Replace these with whatever servers you want to install
	"marksman",
	"pylsp",
	"dockerls",
    "gopls",
    "texlab",
    "ltex",
    "lua_ls",
    "jdtls",
    "vale_ls"
})


-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require('lspconfig').pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 120
        },
        black={
            enabled = true,
            line_length = 120
        },
        jedi = {
            auto_import_modules = {"numpy"}
        }
      }
    }
  }
}

require('lspconfig').gopls.setup{
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

require("lspconfig").ltex.setup{
    -- on_attach = on_attach,
    cmd = { "ltex-ls" },
    filetypes = {  "tex",},
    lang = { },
    flags = { debounce_text_changes = 300 }
}


require("lspconfig").jdtls.setup{}

require("lspconfig").vale_ls.setup{
filetypes={ "markdown", "text","tex" }
}
lsp.setup()

