-- Packer {{{

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd('packadd packer.nvim')
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Visual
  use {
    'RRethy/nvim-base16',
    config = function() vim.cmd('colorscheme base16-da-one-sea') end
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('indent_blankline').setup({ char = '▏' }) end
  }
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup(nil, { css = true }) end
  }

  -- Parsing system
  use { 'nvim-treesitter/nvim-treesitter', 'windwp/nvim-ts-autotag' }
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup() end
  }

  -- Language Server Protocol
  use {
    'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig',
    config = function() require("mason").setup() end
  }

  -- Completion
  use {
    'ray-x/lsp_signature.nvim',
    config = function() require('lsp_signature').setup({ hint_prefix = '■ ' }) end
  }
  use { 'hrsh7th/nvim-cmp', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path' }
  use { 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' }

  -- Other
  use {
    'NMAC427/guess-indent.nvim',
    config = function() require('guess-indent').setup() end
  }
  use 'jghauser/mkdir.nvim'

  if is_bootstrap then require('packer').sync() end
end)

if is_bootstrap then
  print('Plugins are being installed, wait until Packer completes then restart Neovim.')
  return
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand('$MYVIMRC'),
})

-- }}}
-- Option {{{

vim.opt.title = true

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = 'yes'

vim.opt.laststatus = 0
vim.opt.rulerformat = '%w%h%r%m %l:%v · %L'

vim.opt.termguicolors = true

vim.opt.sidescrolloff = 7
vim.opt.scrolloff = 3

vim.opt.list = true
vim.opt.listchars = {
  tab = '› ',
  trail = '·',
  extends = '…',
  precedes = '…',
}
vim.opt.fillchars = {
  fold = ' ',
  eob = ' ',
}

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.foldenable = false
vim.opt.foldmethod = 'indent'

vim.opt.completeopt = { 'menuone', 'noselect' }

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

local languages = { 'html', 'ruby', 'rust' }
local servers = { 'html', 'solargraph', 'rust_analyzer' }

-- }}}
-- Parsing system {{{

require('nvim-treesitter.configs').setup {
  ensure_installed = languages,
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
}

-- }}}
-- Language Server Protocol {{{

local lspconfig = require('lspconfig')
local on_attach = function(_, bufnr) vim.api.nvim_buf_create_user_command(bufnr, 'Format', vim.lsp.buf.formatting, {}) end
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('mason-lspconfig').setup {
  ensure_installed = servers,
  automatic_installation = true,
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- }}}
-- Completion {{{

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  window = { documentation = cmp.config.window.bordered() },
  mapping = cmp.mapping.preset.insert({
    ['<C-Up>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Down>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Esc>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end,
      { 'i', 's' }
    ),
    ['<S-Tab>'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
      { 'i', 's' }
    ),
  }),
}

require('luasnip.loaders.from_vscode').lazy_load()

-- }}}
-- vim: foldenable foldmethod=marker
