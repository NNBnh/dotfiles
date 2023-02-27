vim.opt.termguicolors = true

vim.opt.laststatus = 0
vim.opt.rulerformat = "%w%h%r%m %l:%v"

vim.opt.title = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.scrolloff     = 4
vim.opt.sidescrolloff = 8

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "·", extends = "…" }
vim.opt.fillchars = { eob = ' ' }

vim.opt.cursorline = true

vim.opt.pumheight = 10

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.wildmode = { "longest:full", "full" }

vim.opt.shortmess:append { W = true, I = true, c = true }
if vim.fn.has("nvim-0.9.0") == 1 then vim.opt.shortmess:append { C = true } end

vim.opt.mouse = "a"
vim.opt.timeoutlen = 300
vim.opt.clipboard = "unnamedplus"

vim.opt.smartindent = true
vim.opt.shiftround = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.formatoptions = "jcroqlnt"

vim.opt.autowrite = true
vim.opt.confirm = true

vim.opt.updatetime = 200

vim.opt.undofile = true
vim.opt.undolevels = 10000

for name, icon in pairs({ Error = " ", Warn  = " ", Hint  = " ", Info  = " " }) do
  name = "DiagnosticSign" .. name
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end

vim.g.mapleader      = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

vim.keymap.set({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result"     })
vim.keymap.set({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Previous search result" })


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  {
    "catppuccin/nvim",
    opts = { flavour = "frappe" },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  { "NMAC427/guess-indent.nvim",           event = { "BufReadPre",  "BufNewFile" }                        },
  { "lewis6991/gitsigns.nvim",             event = { "BufReadPre",  "BufNewFile" }                        },
  { "NvChad/nvim-colorizer.lua",           event = { "BufReadPre",  "BufNewFile" }, opts = { css = true } },
  { "lukas-reineke/indent-blankline.nvim", event = { "BufReadPost", "BufNewFile" }, opts = { char = "▏" } },
  { "RRethy/vim-illuminate",               event = { "BufReadPost", "BufNewFile" }                        },
  { "windwp/nvim-autopairs",               event = { "BufReadPost", "BufNewFile" }                        },
  { "kylechui/nvim-surround",              event = { "BufReadPost", "BufNewFile" }                        },
  { "jghauser/mkdir.nvim",                 event = { "BufReadPost", "BufNewFile" }                        },
  { "folke/which-key.nvim", event = "VeryLazy", opts = { window = { margin = { 0, 0, 0, 0 } } } },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },


  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      ensure_installed = "all",
      auto_install = true,
      highlight             = { enable = true                         },
      indent                = { enable = true                         },
      autotag               = { enable = true                         },
      context_commentstring = { enable = true, enable_autocmd = false },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },


  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    opts = {
      ensure_installed = { "html", "rust_analyzer", "solargraph", "svelte", "tailwindcss" },
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason").setup()

      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup(opts)

      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      mason_lspconfig.setup_handlers {
        function(server_name)
          lspconfig[server_name].setup { capabilities = capabilities }
        end,
      }
    end,
  },


  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        keys = {},
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
        },
        opts = { region_check_events = "InsertEnter" },
      },
    },
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")
      local luasnip = require("luasnip")

      return {
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        formatting = { format = require('lspkind').cmp_format() },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip"  },
          { name = "buffer"   },
          { name = "path"     },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-Up>"   ] = cmp.mapping.scroll_docs(-1),
          ["<C-Down>" ] = cmp.mapping.scroll_docs( 1),
          [  "<Esc>"  ] = cmp.mapping.abort(),
          [  "<CR>"   ] = cmp.mapping.confirm(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      }
    end,
  },
}
