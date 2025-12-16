-------------------------------------------------------------------------------
-- Set leader key
-------------------------------------------------------------------------------
vim.g.mapleader = ' '

-------------------------------------------------------------------------------
-- Set UTF-8 encoding
-------------------------------------------------------------------------------
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-------------------------------------------------------------------------------
-- Disable Vi compatibility
-------------------------------------------------------------------------------
vim.o.compatible = false

-------------------------------------------------------------------------------
-- Allow normal backspace usage
-------------------------------------------------------------------------------
vim.o.backspace = 'indent,eol,start'

-------------------------------------------------------------------------------
-- Allow opening new buffer when the current one is not saved
-------------------------------------------------------------------------------
vim.o.hidden = true

-------------------------------------------------------------------------------
-- Enable folding
-------------------------------------------------------------------------------
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99

-------------------------------------------------------------------------------
-- Use indentation of previous line
-------------------------------------------------------------------------------
vim.o.autoindent = true

-------------------------------------------------------------------------------
-- Use spaces instead of tabs
-------------------------------------------------------------------------------
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

-------------------------------------------------------------------------------
-- Enable line numbers
-------------------------------------------------------------------------------
vim.wo.number = true
vim.wo.relativenumber = false

-------------------------------------------------------------------------------
-- Enable syntax highlighting
-------------------------------------------------------------------------------
vim.cmd('syntax on')

-------------------------------------------------------------------------------
-- Set a better status line
-------------------------------------------------------------------------------
vim.o.laststatus = 2
vim.o.ruler = true

-------------------------------------------------------------------------------
-- Enable mouse support
-------------------------------------------------------------------------------
vim.o.mouse = 'a'

-------------------------------------------------------------------------------
-- Improve command-line completion
-------------------------------------------------------------------------------
vim.o.wildmenu = true

-------------------------------------------------------------------------------
-- Set search options
-------------------------------------------------------------------------------
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-------------------------------------------------------------------------------
-- Disable netrw. We'll use nvim-tree for files (MUST happen before plugins for
-- nvim-tree)
-------------------------------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-------------------------------------------------------------------------------
-- Enable true color support
-------------------------------------------------------------------------------
if vim.fn.has('nvim') == 1 then
  vim.o.termguicolors = true
end

-------------------------------------------------------------------------------
-- Plugin Management with lazy.nvim
-------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- UI / THEMES
  { 'nvim-neotest/nvim-nio' },
  {
      'NLKNguyen/papercolor-theme',
      priority = 1000,
      config = function()
          vim.o.background = 'light'
          vim.cmd('colorscheme PaperColor')
      end
  },
  {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
          require('lualine').setup({
              options = {
                  theme = 'papercolor_light',
                  section_separators = '',
                  component_separators = '',
              },
              sections = {
                  lualine_a = {'mode'},
                  lualine_b = {'branch', 'diff', 'diagnostics'},
                  lualine_c = {'filename'},
                  lualine_x = {'encoding', 'fileformat', 'filetype'},
                  lualine_y = {'progress'},
                  lualine_z = {'location'}
              },
              tabline = {
                  lualine_a = {
                      {
                          'buffers',
                          mode = 4,
                          fmt = function(name, context)
                              if context.current then return ' ' .. name end
                              return name
                          end,
                          symbols = { modified = ' ●', alternate_file = ' ↶', directory = '' },
                          show_filename_only = true,
                          hide_filename_extension = false,
                          show_modified_status = true,
                      }
                  },
                  lualine_z = {'tabs'}
              }
          })
      end
  },

  -- File Navigation
  {
      'nvim-tree/nvim-tree.lua',
      config = function()
          require("nvim-tree").setup()
      end
  },
  {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys = {
        { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
        { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
        { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
        { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
      }
  },

  -- Git
  { 'tpope/vim-fugitive' },
  { 'lewis6991/gitsigns.nvim' },

  -- Treesitter
  {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
          -- SAFELY attempt to load the plugin
          local status_ok, configs = pcall(require, "nvim-treesitter.configs")
          if not status_ok then
              return -- If missing, do nothing (prevents crash)
          end

          configs.setup {
              ensure_installed = { 'python', 'cpp', 'lua', 'vim', 'vimdoc', 'query' },
              sync_install = false,
              highlight = { enable = true },
              indent = { enable = true }
          }
      end
  },

  -- LSP & Completion (Updated for Neovim 0.11)
  {
      'neovim/nvim-lspconfig',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',
      },
      config = function()
          local lspconfig = require('lspconfig')
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          -- In Neovim 0.11, we assign config to vim.lsp.config and use vim.lsp.enable
          -- instead of calling .setup()

          -- Python (Pyright)
          if vim.fn.has('nvim-0.11') == 1 then
              vim.lsp.config.pyright = { capabilities = capabilities }
              vim.lsp.enable('pyright')

              vim.lsp.config.clangd = { capabilities = capabilities }
              vim.lsp.enable('clangd')
          else
              -- Fallback for older Neovim versions (just in case)
              lspconfig.pyright.setup({ capabilities = capabilities })
              lspconfig.clangd.setup({ capabilities = capabilities })
          end
      end
  },
  {
      'hrsh7th/nvim-cmp',
      dependencies = {
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'L3MON4D3/LuaSnip'
      },
      config = function()
          local cmp = require('cmp')
          cmp.setup({
            mapping = cmp.mapping.preset.insert(),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'buffer' },
              { name = 'path' }
            })
          })
      end
  },

  -- Debug Adapter Protocol (DAP)
  {
      'mfussenegger/nvim-dap',
      dependencies = {
          'rcarriga/nvim-dap-ui',
          'theHamsta/nvim-dap-virtual-text',
          'nvim-neotest/nvim-nio'
      },
      config = function()
          local dap = require('dap')
          local dapui = require('dapui')

          dapui.setup()
          require('nvim-dap-virtual-text').setup()

          dap.listeners.before.attach.dapui_config = function() dapui.open() end
          dap.listeners.before.launch.dapui_config = function() dapui.open() end
          dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
          dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
      end
  },
})

-------------------------------------------------------------------------------
-- Remappings
-------------------------------------------------------------------------------
-- next buffer
vim.keymap.set('n', '<leader>n', ':bn<CR>', { noremap = true, silent = true })

-- previous buffer
vim.keymap.set('n', '<leader>p', ':bp<CR>', { noremap = true, silent = true })

-- delete current buffer
vim.keymap.set('n', '<leader>x', ':bd<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>X', ':bd!<CR>', { noremap = true, silent = true })

-- navigate splits
vim.keymap.set('n', '<C-J>', '<C-w><C-J>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-K>', '<C-w><C-K>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-L>', '<C-w><C-L>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-H>', '<C-w><C-H>', { noremap = true, silent = true })

-- close split
vim.keymap.set('n', '<leader>q', ':close<CR>', { noremap = true, silent = true })

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- nvim-tree
vim.keymap.set('n', '<leader><Tab>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
